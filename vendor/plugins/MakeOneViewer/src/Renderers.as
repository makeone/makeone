package
{
	import away3d.containers.*;
	import away3d.core.base.*;
	import away3d.core.math.*;
	import away3d.core.render.Renderer;
	import away3d.events.*;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import com.bit101.components.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	[SWF(width="500", height="400", frameRate="90", backgroundColor="#FFFFFF")]
	public class Renderers extends Sprite
	{
		private var View:View3D;
		private var baseObject:ObjectContainer3D;
		private var swfStage:Stage;
		private var cover:Cover;
		private var triangles:Array;
		private var numTriangles:Number = 15;
		private var label1:Label;
		private var label2:Label;
		private var lastTime:Number;
		private var state:String = "Single sided";
		private var renderType:Number = 0;
		private var renderTypeString:String = "Basic";
		
		public function Renderers()
		{
			super();
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
			View.camera.position = new Number3D(400, 500, 400);
			View.camera.lookAt( new Number3D(0, 0, 0) );
			baseObject = new ObjectContainer3D();
			View.scene.addChild(baseObject);
			// Make some triangles
			var newTri:Triangle;
			for(var i:Number = 0; i < numTriangles; i++)
			{
				newTri = makeTriangle();
				// Move to random position
				var max:Number = 90;
				newTri.x = (Math.random()*max)-(max/2);
				newTri.y = (Math.random()*max)-(max/2);
				newTri.z = (Math.random()*max)-(max/2);
				newTri.material = new ColorMaterial();
				triangles.push(newTri);
				baseObject.addChild(newTri);
			}
			View.render();
			addControls();
			
			// only run when user is hovering
			cover = new Cover(this);
			addChild(cover);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(!cover.visible)
			{
				var fps:Number = Math.floor( 1000/(getTimer()-lastTime) );
				label1.text = ""+numTriangles+" "+state+" triangles";
				label2.text = renderTypeString+": "+fps+"fps";
				lastTime = getTimer();
				baseObject.rotationY += 1;
				baseObject.rotationZ += 0.1;
				baseObject.rotationX -= 0.05;
				View.render();
			}
		}
		
		private function makeTriangle():Triangle
		{
			// Create triangle and change face
			var tri:Triangle = new Triangle({bothsides:false});
			tri.a = getVertex();
			tri.b = getVertex();
			tri.c = getVertex();
			return tri;
		}
		
		private function getVertex():Vertex
		{
			var maxSize:Number = 150;
			var newX:Number = (Math.random()*maxSize)-(maxSize/2);
			var newY:Number = (Math.random()*maxSize)-(maxSize/2);
			var newZ:Number = (Math.random()*maxSize)-(maxSize/2);
			var vert:Vertex = new Vertex(newX,newY,newZ);
			return vert;
		}
		
		private function addControls():void
		{
			var pad:Number = 10;
			label1 = new Label(this, pad, pad);
			label1.autoSize = false;
			label1.width = 140;
			var leftButt:PushButton = new PushButton(this, pad, 30, "Both sided", makeBothsided);
			leftButt.width = 140;
			leftButt.height = 20;
			var singleButt:PushButton = new PushButton(this, pad, 55, "Toggle single sided", makeSinglesided);
			singleButt.width = 140;
			singleButt.height = 20;
			
			label2 = new Label(this, pad, 75);
			label2.autoSize = false;
			label2.width = 140;
			
			var rendererButt:PushButton = new PushButton(this, pad, 95, "Change renderer", changeRenderer);
			rendererButt.width = 140;
			rendererButt.height = 20;
			
			addChild(label1);
			addChild(label2);
			addChild(leftButt);
			addChild(singleButt);
		}
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
	}
}