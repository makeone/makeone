/**
 * RadioButton.as
 * Keith Peters
 * version 0.91
 * 
 * A basic radio button component, meant to be used in groups, where only one button in the group can be selected.
 * Currently only one group can be created.
 * 
 * Source code licensed under a Creative Commons Attribution-Share Alike 3.0 License.
 * http://creativecommons.org/licenses/by-sa/3.0/
 * Some Rights Reserved.
 */
 
package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class RadioButton extends Component
	{
		private var _back:Sprite;
		private var _button:Sprite;
		private var _selected:Boolean = false;
		private var _label:Label;
		private var _labelText:String = "";
		
		private static var buttons:Array;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this RadioButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The string to use for the initial label of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function RadioButton(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", checked:Boolean = false, defaultHandler:Function = null)
		{
			RadioButton.addButton(this);
			_selected = checked;
			_labelText = label;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
		}
		
		/**
		 * Static method to add the newly created RadioButton to the list of buttons in the group.
		 * @param rb The RadioButton to add.
		 */
		private static function addButton(rb:RadioButton):void
		{
			if(buttons == null)
			{
				buttons = new Array();
			}
			buttons.push(rb);
		}
		
		/**
		 * Unselects all RadioButtons in the group, except the one passed.
		 * This could use some rethinking or better naming.
		 * @param rb The RadioButton to remain selected.
		 */
		private static function clear(rb:RadioButton):void
		{
			for(var i:uint = 0; i < buttons.length; i++)
			{
				if(buttons[i] != rb)
				{
					buttons[i].selected = false;
				}
			}
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(10, 10);
			
			buttonMode = true;
			useHandCursor = true;
			
			addEventListener(MouseEvent.CLICK, onClick, false, 1);
			selected = _selected;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_button = new Sprite();
			_button.filters = [getShadow(1)];
			_button.visible = false;
			addChild(_button);
			
			_label = new Label();
			addChild(_label);
			
		}
		
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawCircle(_width / 2, _height / 2, _width / 2);
			_back.graphics.endFill();
			
			_button.graphics.clear();
			_button.graphics.beginFill(Style.BUTTON_FACE);
			_button.graphics.drawCircle(_width / 2, _height / 2, _width / 2 - 2);
			
			_label.x = _width + 2;
			_label.y = _height / 2 - _label.height / 2;
			_label.text = _labelText;
		}
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal click handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onClick(event:MouseEvent):void
		{
			selected = true;
		}
		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the selected state of this CheckBox.
		 */
		public function set selected(s:Boolean):void
		{
			_selected = s;
			_button.visible = _selected;
			if(_selected)
			{
				RadioButton.clear(this);
			}
		}
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * Sets / gets the label text shown on this CheckBox.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
			invalidate();
		}
		public function get label():String
		{
			return _labelText;
		}
		
	}
}