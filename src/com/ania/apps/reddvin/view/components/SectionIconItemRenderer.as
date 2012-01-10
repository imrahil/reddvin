/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.components
{
	import com.ania.apps.reddvin.constants.Resources;
	import com.ania.apps.reddvin.model.vo.RedditVO;
	
	import mx.core.mx_internal;
	
	import spark.components.IconItemRenderer;
	
	use namespace mx_internal;

	public class SectionIconItemRenderer extends IconItemRenderer
	{
		public function SectionIconItemRenderer()
		{
			super();
			
			this.labelField = "title";
			this.messageFunction = itemMessageFunction;
			this.styleName = "myItemStyle";
			
			this.iconFunction = myIconFunction;
			this.iconWidth = 70;
			this.iconHeight = 70;
			this.iconFillMode = "clip";
			this.opaqueBackground = 0xFFFFFF;
		}
		
		private function myIconFunction(item:Object):Object
		{
			var singleItem:RedditVO = item as RedditVO;
			
			if (singleItem.thumbnail != "")
			{
				return singleItem.thumbnail;
			}
			else
			{
				return Resources.ARROW_RIGHT;
			}
		}
		
		private function itemMessageFunction(item:Object):String
		{
			var singleItem:RedditVO = item as RedditVO;
			
			return singleItem.num_comments + " comments, in: " + singleItem.subreddit + ", " +
				"by: " + singleItem.author + ", domain: " + singleItem.domain;
		}

		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var iconWidth:Number = 0;
			var iconHeight:Number = 0;
//			var decoratorWidth:Number = 0;
//			var decoratorHeight:Number = 0;
			
			var hasLabel:Boolean = labelDisplay && labelDisplay.text != "";
			var hasMessage:Boolean = messageDisplay && messageDisplay.text != "";
			
			var paddingLeft:Number   = getStyle("paddingLeft");
			var paddingRight:Number  = getStyle("paddingRight");
			var paddingTop:Number    = getStyle("paddingTop");
			var paddingBottom:Number = getStyle("paddingBottom");
			var horizontalGap:Number = getStyle("horizontalGap");
			var verticalAlign:String = getStyle("verticalAlign");
			var verticalGap:Number   = (hasLabel && hasMessage) ? getStyle("verticalGap") : 0;
			
			var vAlign:Number;
			if (verticalAlign == "top")
				vAlign = 0;
			else if (verticalAlign == "bottom")
				vAlign = 1;
			else // if (verticalAlign == "middle")
				vAlign = 0.5;
			// made "middle" last even though it's most likely so it is the default and if someone 
			// types "center", then it will still vertically center itself.
			
			var viewWidth:Number  = unscaledWidth  - paddingLeft - paddingRight;
			var viewHeight:Number = unscaledHeight - paddingTop  - paddingBottom;
			
			// icon is on the left
			if (iconDisplay)
			{
				// set the icon's position and size
				setElementSize(iconDisplay, this.iconWidth, this.iconHeight);
				
				iconWidth = iconDisplay.getLayoutBoundsWidth();
				iconHeight = iconDisplay.getLayoutBoundsHeight();
				
				// use vAlign to position the icon.
				var iconDisplayY:Number = Math.round(vAlign * (viewHeight - iconHeight)) + paddingTop;
				setElementPosition(iconDisplay, unscaledWidth - paddingRight - iconWidth, iconDisplayY);
			}
			
			// decorator is aligned next to icon
//			if (decoratorDisplay)
//			{
//				decoratorWidth = getElementPreferredWidth(decoratorDisplay);
//				decoratorHeight = getElementPreferredHeight(decoratorDisplay);
//				
//				setElementSize(decoratorDisplay, decoratorWidth, decoratorHeight);
//				
//				// decorator is always right aligned, vertically centered
//				var decoratorY:Number = Math.round(0.5 * (viewHeight - decoratorHeight)) + paddingTop;
//				setElementPosition(decoratorDisplay, unscaledWidth - paddingRight - decoratorWidth, decoratorY);
//			}
			
			// Figure out how much space we have for label and message as well as the 
			// starting left position
			var labelComponentsViewWidth:Number = viewWidth - iconWidth;	// - decoratorWidth;
			
			// don't forget the extra gap padding if these elements exist
			if (iconDisplay)
				labelComponentsViewWidth -= horizontalGap;
//			if (decoratorDisplay)
//				labelComponentsViewWidth -= horizontalGap;
			
			var labelComponentsX:Number = paddingLeft;
//			if (iconDisplay)
//				labelComponentsX += iconWidth + horizontalGap;
			
			// calculte the natural height for the label
			var labelTextHeight:Number = 0;
			
			if (hasLabel)
			{
				// reset text if it was truncated before.
				if (labelDisplay.isTruncated)
					labelDisplay.text = labelText;
				
				// commit styles to make sure it uses updated look
				labelDisplay.commitStyles();
				
				labelTextHeight = getElementPreferredHeight(labelDisplay);
			}
			
			if (hasMessage)
			{
				// commit styles to make sure it uses updated look
				messageDisplay.commitStyles();
			}
			
			// now size and position the elements, 3 different configurations we care about:
			// 1) label and message
			// 2) label only
			// 3) message only
			
			// label display goes on top
			// message display goes below
			
			var labelWidth:Number = 0;
			var labelHeight:Number = 0;
			var messageWidth:Number = 0;
			var messageHeight:Number = 0;
			
			if (hasLabel)
			{
				// handle labelDisplay.  it can only be 1 line
				
				// width of label takes up rest of space
				// height only takes up what it needs so we can properly place the message
				// and make sure verticalAlign is operating on a correct value.
				labelWidth = Math.max(labelComponentsViewWidth, 0);
				labelHeight = labelTextHeight;
				
				if (labelWidth == 0)
					setElementSize(labelDisplay, NaN, 0);
				else
					setElementSize(labelDisplay, labelWidth, labelHeight);
				
				// attempt to truncate text
//				labelDisplay.truncateToFit();
			}
			
			if (hasMessage)
			{
				// handle message...because the text is multi-line, measuring and layout 
				// can be somewhat tricky
				messageWidth = Math.max(labelComponentsViewWidth, 0);
				
				// We get called with unscaledWidth = 0 a few times...
				// rather than deal with this case normally, 
				// we can just special-case it later to do something smarter
				if (messageWidth == 0)
				{
					// if unscaledWidth is 0, we want to make sure messageDisplay is invisible.
					// we could set messageDisplay's width to 0, but that would cause an extra 
					// layout pass because of the text reflow logic.  Because of that, we 
					// can just set its height to 0.
					setElementSize(messageDisplay, NaN, 0);
				}
				else
				{
					// grab old textDisplay height before resizing it
					var oldPreferredMessageHeight:Number = getElementPreferredHeight(messageDisplay);
					
					// keep track of oldUnscaledWidth so we have a good guess as to the width 
					// of the messageDisplay on the next measure() pass
					oldUnscaledWidth = unscaledWidth;
					
					// set the width of messageDisplay to messageWidth.
					// set the height to oldMessageHeight.  If the height's actually wrong, 
					// we'll invalidateSize() and go through this layout pass again anyways
					setElementSize(messageDisplay, messageWidth, oldPreferredMessageHeight);
					
					// grab new messageDisplay height after the messageDisplay has taken its final width
					var newPreferredMessageHeight:Number = getElementPreferredHeight(messageDisplay);
					
					// if the resize caused the messageDisplay's height to change (because of 
					// text reflow), then we need to remeasure ourselves with our new width
					if (oldPreferredMessageHeight != newPreferredMessageHeight)
						invalidateSize();
					
					messageHeight = newPreferredMessageHeight;
				}
				
				// since it's multi-line, no need to truncate
				//if (messageDisplay.isTruncated)
				//    messageDisplay.text = messageText;
				//messageDisplay.truncateToFit();
			}
			else
			{
				if (messageDisplay)
					setElementSize(messageDisplay, 0, 0);
			}
			
			// Position the text components now that we know all heights so we can respect verticalAlign style
			var totalHeight:Number = 0;
			var labelComponentsY:Number = 0; 
			
			// Heights used in our alignment calculations.  We only care about the "real" ascent 
			var labelAlignmentHeight:Number = 0; 
			var messageAlignmentHeight:Number = 0; 
			
			if (hasLabel)
				labelAlignmentHeight = getElementPreferredHeight(labelDisplay);
			if (hasMessage)
				messageAlignmentHeight = getElementPreferredHeight(messageDisplay);
			
			totalHeight = labelAlignmentHeight + messageAlignmentHeight + verticalGap;          
			labelComponentsY = Math.round(vAlign * (viewHeight - totalHeight)) + paddingTop;
			
			if (labelDisplay)
				setElementPosition(labelDisplay, labelComponentsX, labelComponentsY);
			
			if (messageDisplay)
			{
				var messageY:Number = labelComponentsY + labelAlignmentHeight + verticalGap;
				setElementPosition(messageDisplay, labelComponentsX, messageY);
			}
		}
		
		override protected function createLabelDisplay():void
		{
			super.createLabelDisplay();
			labelDisplay.multiline = true;
			labelDisplay.wordWrap = true;
		}
	}
}