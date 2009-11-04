package {

	
	import away3d.containers.*;
	import away3d.core.base.*;
	import away3d.core.math.*;
	import away3d.core.render.*;
	import away3d.events.*;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import com.bit101.components.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.getTimer;
	import flash.xml.XMLDocument;

	[SWF(width="500", height="400", frameRate="90", backgroundColor="#FFFFFF")]
	public class MakeOneViewer extends Sprite
	{
		//base object, stage, and view
		private var View:View3D;
		private var baseObject:ObjectContainer3D;
		private var swfStage:Stage;
		
		//cover for non-active scene
		private var cover:Cover;
		
		//objects will be represented as triangle mesh
		private var triangles:Array;
		private var numTriangles:Number = 0;
		
		//object info
		private var label1:Label;
		private var label2:Label;
		
		private var lastTime:Number;
		private var state:String = "Single sided";
		private var renderType:Number = 0;
		private var renderTypeString:String = "Basic";
		
		//scale value (zoom degree) for scene
		private var scale:Number = 100;
		
		//navigation variables
		private var mouseIsDown:Boolean = false;
		private var downX:Number = 0;
		private var downY:Number = 0;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;

		
		//vertex point range for initial scaling
		private var rangeHigh:Number = 0;
		private var rangeLow:Number = 0;
		private var rangeDist:Number = 0;
		
		//for data retrieval
		private var basePath:String = "/models/";
		private var endPath:String = ".xmlj";
		//private var basePath:String = "http://ambrosia.mitre.org:3000/";
		//private var endPath:String = ".xml";
		private var path:String = '';

		public function MakeOneViewer()
		{
			super();
			loadData();
			triangles = new Array();
			// prep for handling resizing events
            swfStage = this.stage;
			swfStage.scaleMode = StageScaleMode.NO_SCALE;
			swfStage.align = StageAlign.TOP;
			
			

			// create a 3D-viewport
			View = new View3D({x:250, y:200});
			View.renderer = Renderer.BASIC;
			// add viewport to the stage
			addChild(View);
			//View.camera.position = new Number3D(400, 500, 400);
			View.camera.position = new Number3D(500, 500, 500);
			View.camera.lookAt( new Number3D(0, 0, 0) );
			baseObject = new ObjectContainer3D();
			View.scene.addChild(baseObject);


			View.render();
			addControls();
			
			// only run when user is hovering
			cover = new Cover(this);
			addChild(cover);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);	
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
		}

		private function reset():void
		{
			View.camera.position = new Number3D(500, 500, 500);
			View.camera.lookAt(new Number3D(0,0,0));
			mouseIsDown = false;
			rangeDist = rangeHigh - rangeLow;
			scale = (rangeHigh * 100)/rangeDist;
			baseObject.scaleZ = scale;
			baseObject.scaleY = scale;
			baseObject.scaleX = scale;
			baseObject.rotationX = 0;
			baseObject.rotationY = 0;
			baseObject.rotationZ = 0;
			View.render();
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(!cover.visible)
			{
				var fps:Number = Math.floor( 1000/(getTimer()-lastTime) );
				label1.text = ""+numTriangles+" triangles";
				label2.text = fps+" fps";
				lastTime = getTimer();
				View.render();
			}
		}

		private function mouseDownEvent(e:MouseEvent):void
		{
			mouseIsDown = true;
			downX = stage.mouseX;
			downY = stage.mouseY;
		}

		private function mouseUpEvent(e:MouseEvent):void
		{
			mouseIsDown = false;
		}
		
		private function mouseMoveEvent(e:MouseEvent):void
		{
			if (mouseIsDown) 
			{
				var xDelta:Number = (downY - e.localY);
				var yDelta:Number = (downX - e.localX);
//				View.camera.position = new Number3D(View.camera.position.x + xDelta/100, View.camera.position.y + yDelta/100, View.camera.position.z);
//				View.render();
				baseObject.rotationX += xDelta/100;
				baseObject.rotationY += yDelta/100;
	
			}
		}

		private function mouseWheelEvent(e:MouseEvent):void
		{
			scale += e.delta;
			baseObject.scaleZ = scale;
			baseObject.scaleY = scale;
			baseObject.scaleX = scale;
		}
		
		
		private function scaleTriangles():void
		{
			
		}
		
		
		private function addControls():void
		{
			var pad:Number = 10;
			label1 = new Label(this, pad, pad);
			label1.autoSize = false;
			label1.width = 140;
			
			label2 = new Label(this, pad, 30);
			label2.autoSize = false;
			label2.width = 140;
			
/*			
			var leftButt:PushButton = new PushButton(this, pad, 30, "reset view", reset);
			leftButt.width = 140;
			leftButt.height = 20;
		
			var singleButt:PushButton = new PushButton(this, pad, 55, "Toggle single sided", makeSinglesided);
			singleButt.width = 140;
			singleButt.height = 20;		
			
			var rendererButt:PushButton = new PushButton(this, pad, 95, "Change renderer", changeRenderer);
			rendererButt.width = 140;
			rendererButt.height = 20;
*/
			
			addChild(label1);
			addChild(label2);
//			addChild(leftButt);
//			addChild(singleButt);
		}
		
/*
		private function makeBothsided(e:MouseEvent):void
		{
			for(var i:Number = 0; i < triangles.length ; i++){
				var tri:Triangle = triangles[i] as Triangle;
				tri.bothsides = true;
				tri.invertFaces();
				state = "Both sided";
			}
		}
		private function makeSinglesided(e:MouseEvent):void
		{
			for(var i:Number = 0; i < triangles.length ; i++){
				var tri:Triangle = triangles[i] as Triangle;
				tri.bothsides = false;
				tri.invertFaces();
				state = "Single sided";
			}
		}
*/
		
		private function changeRenderer(e:MouseEvent):void
		{
			renderType++;
			if(renderType == 3){ renderType = 0; }
			switch(renderType){
				case 0 : View.renderer = Renderer.BASIC; renderTypeString = "Basic"; break;
				case 1 : View.renderer = Renderer.CORRECT_Z_ORDER; renderTypeString = "Correct Z order"; break;
				case 2 : View.renderer = Renderer.INTERSECTING_OBJECTS; renderTypeString = "Intersecting Objects"; break;
			}
		}
		
		private function loadData() :void 
		{
			var model:String = stage.loaderInfo.parameters.model;
			path = basePath + model + endPath;
			var request:URLRequest = new URLRequest(path);
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT; //default
			loader.addEventListener(Event.COMPLETE, urlLoader_complete);
			loader.load(request);
			
			function urlLoader_complete(evt:Event):void 
			{ 
				var xDoc:XMLDocument = new XMLDocument();
				xDoc.ignoreWhite = true;
				var meshXML:XML = XML(loader.data);
				xDoc.parseXML(meshXML.toXMLString());
				
				triangles = new Array();
				numTriangles = 0;
				for each (var facet:XML in meshXML.facet)
				{
					var tri:Triangle = new Triangle({bothsides:false});
					tri.a = new Vertex(facet.vertex[0].x, facet.vertex[0].y, facet.vertex[0].z);
					tri.b = new Vertex(facet.vertex[1].x, facet.vertex[1].y, facet.vertex[1].z);
					tri.c = new Vertex(facet.vertex[2].x, facet.vertex[2].y, facet.vertex[2].z);
					state = facet.vertex[2].z;
					tri.material = new ColorMaterial();
					triangles.push(tri);
					baseObject.addChild(tri); 	
					numTriangles += 1;
					
					//determine vertex xyz ranges
					if (facet.vertex[0].x > rangeHigh) { rangeHigh = facet.vertex[0].x; }
					if (facet.vertex[0].y > rangeHigh) { rangeHigh = facet.vertex[0].y; }
					if (facet.vertex[0].z > rangeHigh) { rangeHigh = facet.vertex[0].z; }
					if (facet.vertex[0].x < rangeLow) { rangeLow = facet.vertex[0].x; }
					if (facet.vertex[0].y < rangeLow) { rangeLow = facet.vertex[0].y; }
					if (facet.vertex[0].z < rangeLow) { rangeLow = facet.vertex[0].z; }			
				}
				//normalize scale to 100 units based on computed range
				rangeDist = rangeHigh - rangeLow;
				scale = (rangeHigh * 100)/rangeDist;
				baseObject.scaleZ = scale;
				baseObject.scaleY = scale;
				baseObject.scaleX = scale;	
			}
			
		}
		
	}
}
