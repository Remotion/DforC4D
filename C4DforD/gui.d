module gui;


/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////

import c4d_prepass : C4D_FOUR_BYTE;



enum
{
	GUI_H_
};

enum
{
	FONT_DEFAULT		= 0,
	FONT_STANDARD		= 1,
	FONT_BOLD				= 2,
	FONT_MONOSPACED	= 3
};

// Coffee Qualifiers
enum
{
	QSHIFT = 1,
	QCTRL	 = 2,	// on the Mac this could indicate either Ctrl or Cmd key
	QALT	 = 4,
	QALT2	 = 8,
	QQUAL_

};

// COFFEE keys
enum
{
	KEY_MLEFT		= 0xF000,
	KEY_MRIGHT	= 0xF001,
	KEY_MMIDDLE	= 0xF002,
	KEY_MX1			= 0xF003,
	KEY_MX2			= 0xF004,

	// modifier keys
	KEY_SHIFT			= 0xF010,
	KEY_CONTROL		= 0xF011,
	KEY_ALT				= 0xF012,
	KEY_CAPSLOCK	= 0xF013,
	KEY_MODIFIERS = 0xF014,
	KEY_COMMAND		= 0xF015,

	KEY_BACKSPACE	= 0xF108,	// backspace key
	KEY_TAB				= 0xF109,	// tab key
	KEY_ENTER			= 0xF10D,	// enter key
	KEY_ESC				= 0xF11B,	// escape key
	KEY_SPACE			= 0xF120,	// spacebar key
	KEY_DELETE		= 0xF17F,	// delete key

	KEY_UP				= 0xF180,	// up arrow key
	KEY_DOWN			= 0xF181,	// down arrow key
	KEY_LEFT			= 0xF182,	// left arrow key
	KEY_RIGHT			= 0xF183,	// right arrow key
	KEY_PGUP			= 0xF184,	// page up key
	KEY_PGDOWN		= 0xF185,	// page down key
	KEY_HOME			= 0xF186,	// home key
	KEY_END				= 0xF187,	// end key
	KEY_INSERT		= 0xF188,	// insert key

	// function keys
	KEY_F1	= 0xF1A0,
	KEY_F2	= 0xF1A1,
	KEY_F3	= 0xF1A2,
	KEY_F4	= 0xF1A3,
	KEY_F5	= 0xF1A4,
	KEY_F6	= 0xF1A5,
	KEY_F7	= 0xF1A6,
	KEY_F8	= 0xF1A7,
	KEY_F9	= 0xF1A8,
	KEY_F10	= 0xF1A9,
	KEY_F11	= 0xF1AA,
	KEY_F12	= 0xF1AB,
	KEY_F13	= 0xF1AC,
	KEY_F14	= 0xF1AD,
	KEY_F15	= 0xF1AE,
	KEY_F16	= 0xF1AF,
	KEY_F17	= 0xF1B0,
	KEY_F18	= 0xF1B1,
	KEY_F19	= 0xF1B2,
	KEY_F20	= 0xF1B3,
	KEY_F21	= 0xF1B4,
	KEY_F22	= 0xF1B5,
	KEY_F23	= 0xF1B6,
	KEY_F24	= 0xF1B7,
	KEY_F25	= 0xF1B8,
	KEY_F26	= 0xF1B9,
	KEY_F27	= 0xF1BA,
	KEY_F28	= 0xF1BB,
	KEY_F29	= 0xF1BC,
	KEY_F30	= 0xF1BD,
	KEY_F31	= 0xF1BE,
	KEY_F32	= 0xF1BF
};

enum
{
	BfBLACK		 = 0,
	BfWHITE		 = 1,
	BfLTGRAY	 = 2,
	BfLTRED		 = 3,
	BfLTGREEN	 = 4,
	BfLTBLUE	 = 5,
	BfLTYELLOW = 6,
	BfGRAY		 = 7,
	BfRED			 = 8,
	BfGREEN		 = 9,
	BfBLUE		 = 10,
	BfYELLOW	 = 11,
	BfDGRAY		 = 12,
	BfDRED		 = 13,
	BfDGREEN	 = 14,
	BfDBLUE		 = 15,
	BfDYELLOW	 = 16,
	BfDWHITE	 = 17,
	BfORANGE	 = 18,
	BfBROWN		 = 19,
	BfPURPLE	 = 20
};


enum
{
	ARROW_LEFT				= 1,
	ARROW_RIGHT				= 2,
	ARROW_UP					= 3,
	ARROW_DOWN				= 4,

	ARROW_SMALL_LEFT	= 5,
	ARROW_SMALL_RIGHT = 6,
	ARROW_SMALL_UP		= 7,
	ARROW_SMALL_DOWN	= 8
};

enum
{
	// Bitmap modes
	BMP_NORMAL						 = 0,
	BMP_NORMALSCALED			 = 1,
	BMP_EMBOSSED					 = 3,
	BMP_ALLOWALPHA				 = 256,	// bitmask
	BMP_APPLY_COLORPROFILE = 512,
	BMP_DIMIMAGE					 = 1024,
	BMP_MIRROR_H					 = 2048,
	BMP_MIRROR_H_FORBID		 = 4096,
	BMP_MIRROR_V					 = 8192,	// force bitmap mirror
	BMP_MIRROR_V_FORBID		 = 16384
};

// Flags for Layout - bf_flags
enum
{
	BFV_GRIDGROUP_EQUALCOLS			= 1,			// each column has the same width
	BFV_GRIDGROUP_EQUALROWS			=	2,			// each row has the same height
	BFV_CMD_EQUALCOLUMNS				= 2048,		// gleiche Spaltenbreite
	BFV_BORDERGROUP_CHECKBOX		= 4096,		// checkbox in title of a bordergroup
	BFV_BORDERGROUP_FOLD				= 8192,		// fold symbol in title of a bordergroup
	BFV_BORDERGROUP_FOLD_OPEN		= 16384,	// fold symbol in title of a bordergroup group is opened, otherwise closed
	BFV_BORDERGROUP_FOLD2				= 32768,	// foldable group, but NO switchgadget
	BFV_GRIDGROUP_ALLOW_WEIGHTS	= 65536,	// allow the user to move the weights
	BFV_GRIDGROUP_FORBID_MIRROR	= 131072,	// dont mirror the layout of this group

	BFV_DIALOG_REMOVEABLE				= 4,			// dialog is removeable
	BFV_DIALOG_BAR_VERT					= 8,			// dialog has a vert. dialogbar
	BFV_DIALOG_NOBUTTONS				= 16,			// no Button-Bar

	//BFV_GRIDGROUP_LAYOUTER	= 256,	// mark a layouting-frame
	BFV_LAYOUTGROUP_PALETTEOUTLINES = 512,
	BFV_IGNORE_FOCUS								= 1024,

	BFV_TABGROUP_RELOADDIALOG				= 2048,	// ok, it's a hack
	BFV_LAYOUTGROUP_NODROP					= 4096,
	BFV_LAYOUTGROUP_NODROP2					= 8192,

	BFx_NOEQUAL											= 64,

	BFV_
};

/+
enum														//CommandResourceObj
{
	RESOURCE_MENU		 = C4D_FOUR_BYTE("rmnu"),	// GetCResource();
	RESOURCE_DIALOG		= C4D_FOUR_BYTE("rdlg"),	// GetCResource();
	RESOURCE_CONTAINER = C4D_FOUR_BYTE("rcnt")		// GetCResource();
};
+/
enum	// MenuResourceObj
{
	MENURESOURCE_SUBMENU			= 1,
	MENURESOURCE_SEPERATOR		= 2,
	MENURESOURCE_COMMAND			= 3,
	MENURESOURCE_SUBTITLE			= 4,
	MENURESOURCE_STRING				= 5,
	MENURESOURCE_MENURESOURCE = 6
};

// BorderTypes
enum
{
	BORDER_NONE								= 0,
	BORDER_THIN_IN						= 1,
	BORDER_THIN_OUT						= 2,
	BORDER_IN									= 3,
	BORDER_OUT								= 4,
	BORDER_GROUP_IN						= 5,
	BORDER_GROUP_OUT					= 6,
	BORDER_OUT2								= 7,
	BORDER_OUT3								= 8,
	BORDER_BLACK							= 9,
	BORDER_ACTIVE_1						= 10,
	BORDER_ACTIVE_2						= 11,
	BORDER_GROUP_TOP					= 12,
	BORDER_ACTIVE_3						= 13,
	BORDER_ACTIVE_4						= 14,
	BORDER_ROUND							= 15,
	BORDER_SCHEME_EDIT				= 16,
	BORDER_SCHEME_EDIT_NUMERIC = 17,
	BORDER_OUT3l							= 18,
	BORDER_OUT3r							= 19,


	BORDER_MASK						 = 0x1FFFFFFF,
	BORDER_WITH_TITLE_MONO = 0x20000000,
	BORDER_WITH_TITLE_BOLD = 0x40000000,
	BORDER_WITH_TITLE			 = 0x80000000
};

enum	// DialogResourceObj
{
	TAB_TABS		 = 0,
	TAB_NOSELECT = 1,
	TAB_CYCLE		 = 2,
	TAB_RADIO		 = 3,
	TAB_VLTABS	 = 4,
	TAB_VRTABS	 = 5,

	// binfo->pos BaseFrame vertical and horizontal orientation
	BFV_CENTER								 = 0,
	BFV_TOP										 = 1,	// (1<<0),
	BFV_BOTTOM								 = 2,	// (1<<1),
	BFV_FIT										 = 3,	// (BFV_BOTTOM|BFV_TOP),
	BFV_SCALE									 = 4,	// (1<<2),
	BFV_SCALEFIT							 = 7,	// (BFV_SCALE|BFV_FIT),
	BFV_MASK									 = 3,

	BFH_CENTER								 = 0,
	BFH_LEFT									 = 8,		// 1<<3
	BFH_RIGHT									 = 16,	// 1<<4
	BFH_FIT										 = 24,
	BFH_SCALE									 = 32,	// 1<<5
	BFH_SCALEFIT							 = 56,
	BFH_MASK									 = 24,

	DR_MULTILINE_MONOSPACED		 = 1,
	DR_MULTILINE_SYNTAXCOLOR	 = 2,
	DR_MULTILINE_STATUSBAR		 = 4,
	DR_MULTILINE_HIGHLIGHTLINE = 8,
	DR_MULTILINE_READONLY			 = 16,
	//DR_MULTILINE_RESERVED				= 32,
	//DR_MULTILINE_RESERVED				= 64,
	DR_MULTILINE_PYTHON					= 128,
	DR_MULTILINE_WORDWRAP				= 256,

	DR_COLORFIELD_NO_BRIGHTNESS = 1,
	DR_COLORFIELD_NO_COLOR			= 2,
	DR_COLORFIELD_BODYPAINT			= 4,	// uses the BP style
	DR_COLORFIELD_ICC_BASEDOC		= 8,	// use iccprofile of the current basedocument
	DR_COLORFIELD_ICC_BPTEX			= 16,	// uses iccprofile of the current bp texture

	DROLDWIN_SDK					= C4D_FOUR_BYTE("sdk8"),//C4D_FOUR_BYTE("sdk8"),

	DIALOGRESOURCE_
};



// Flags fuer CommandGadget
enum
{
	CMD_POPUP_RIGHT	= 1,
	CMD_POPUP_BELOW	= 2,
	CMD_PIC					= 4,
	CMD_TOGGLE			= 8,		// soll togglebar sein
	CMD_TEXT				= 16,		// Text
	CMD_SHORTCUT		= 32,		// Shortcut
	CMD_ARROW				= 64,		// Pfeile fuer Menu
	CMD_VERT				= 128,	// vertikale Anordnung von Text und Icon
	CMD_BUTTONLIKE	= 256,	// ist ein Button=true, Menueintrag=false
	CMD_MENU				= 512,	// ist ein Menueintrag, daher keine Eintragung beim Commando, zwecks Updates
	CMD_CYCLE				= 1024,	// bleibt eingerastet
	CMD_EDITPALETTE	= 4096,	// CommandManagerFlag, dieser Button ist im PalettenManager
	CMD_SMALLICONS	= 8192,	// Small icons (textheight)

	CMD_VALUE				= 0x3FFFFFFF,
	CMD_ENABLED			= 0x40000000,

	CMD_
};

// Flags for PopUps
enum
{
	POPUP_ABOVE						= 1,		// sdk: open to this direction relative to mouse
	POPUP_BELOW						= 2,		// sdk: open to this direction relative to mouse
	POPUP_CENTERVERT			= 3,		// sdk: open to this direction relative to mouse

	POPUP_LEFT						= 4,		// sdk: open to this direction relative to mouse
	POPUP_RIGHT						= 8,		// sdk: open to this direction relative to mouse
	POPUP_CENTERHORIZ			= 12,		// sdk: open to this direction relative to mouse

	POPUP_ADJUSTWIDTH			= 16,		// only for internal usage
	POPUP_ADJUSTHEIGHT		= 32,		// only for internal usage

	POPUP_EXECUTECOMMANDS	= 64,		// sdk: execute command immediatly

	POPUP_ALLOWUNDOCK			= 128,	// allow to undock popupmenu
	POPUP_ALLOWUNDOCK_REC	= 256,	// allow to undock popupmenu for children

	POPUP_
};

// flags for coffee-manager-window
enum
{
	SCROLLGROUP_VERT												= 4,
	SCROLLGROUP_HORIZ												= 8,
	SCROLLGROUP_NOBLIT											= 16,
	SCROLLGROUP_LEFT												= 32,
	SCROLLGROUP_BORDERIN										= 64,
	SCROLLGROUP_STATUSBAR										= 128,
	SCROLLGROUP_AUTOHORIZ										= 256,
	SCROLLGROUP_AUTOVERT										= 512,
	SCROLLGROUP_NOSCROLLER									= 1024,
	SCROLLGROUP_NOVGAP											= 2048,
	SCROLLGROUP_STATUSBAR_EXT_GROUP					= 4096,

	ID_SCROLLGROUP_STATUSBAR_EXTLEFT_GROUP	= 200000239,
	ID_SCROLLGROUP_STATUSBAR_EXTRIGHT_GROUP	= 200000240
};

// Modes for MouseSelectAreas function
enum
{
	MOUSESELECT_NOCROSSCURSOR	= 0x40000000,	//(1<<30)
	MOUSESELECT_NOFILL				= 0x20000000,	//(1<<29)

	MOUSESELECT_RECTANGLE			= 1,
	MOUSESELECT_POLYGON				= 2,
	MOUSESELECT_FREE					= 3,
	MOUSESELECT_OUTLINE_RECT	= MOUSESELECT_NOFILL | MOUSESELECT_RECTANGLE,
	MOUSESELECT_OUTLINE_POLY	= MOUSESELECT_NOFILL | MOUSESELECT_POLYGON,
	MOUSESELECT_OUTLINE_FREE	= MOUSESELECT_NOFILL | MOUSESELECT_FREE
};

enum
{
	MANAGER_NONE,

	MANAGER_SCROLLER_HORIZ,
	MANAGER_SCROLLER_VERT,
	MANAGER_CLOSEBUTTON,
	MANAGER_SIZEABLE,
	MANAGER_TITLE,
	MANAGER_ID,
	MANAGER_MENUID,
	MANAGER_NOBLITBIT,
	MANAGER_WANTOWNSTATUSBAR,

	MANAGER_DUMMY
};


// focus definitions
enum										// focus of coffee-frames
{
	FOCUS_OFF				 = 0,	// has no focus
	FOCUS_ON				 = 1,	// has focus and window is active
	FOCUS_INACT			 = 2,	// has focus but window is inactive
	FOCUS_HIDDEN		 = 3,	// focus is hidden through ENTER
	FOCUS_INPROGRESS = 4,
	FOCUS_
};



enum
{
	BFM_INIT										            = C4D_FOUR_BYTE("bINI"),

	BFM_TIMER_MESSAGE						                    = 10020,

	BFM_CALCSIZE								                = C4D_FOUR_BYTE("bCAS"),

	BFM_CHECKCLOSE							                    = C4D_FOUR_BYTE("chkc"),	// versendet das physic. fenster geschickt, wenn user fenster schliessen will
	BFM_CHECKCLOSE_LAYOUTSWITCH                                 = C4D_FOUR_BYTE("ccll"),
	BFM_ASKCLOSE								                = C4D_FOUR_BYTE("askc"),	// true zurueck, wer etwas gegen das schliessen des fensters hat
	BFM_DESTROY									                = C4D_FOUR_BYTE("dsty"),	// unweigerliches schliessen

	BFM_CLOSEWINDOW							                    = C4D_FOUR_BYTE("clos"),	// ParentMessage zum schliessen des Fenster

	BFM_ASK_TABSWITCH						                    = C4D_FOUR_BYTE("stab"),	// ask for switching tabs

	BFM_VISIBLE_ON							                    = C4D_FOUR_BYTE("visT"),	// Message about changing to visibility
	BFM_VISIBLE_OFF							                    = C4D_FOUR_BYTE("visF"),	// Message about changing to visibility

	BFM_PARENT_TITLECHNG				                        = C4D_FOUR_BYTE("pren"),	// ParentNotify about titlechng
	BFM_RENAMEWINDOW						                    = C4D_FOUR_BYTE("wren"),	// rename window message

	BFM_GETACTIVETABTITLE				                        = C4D_FOUR_BYTE("tact"),	// asking for activetab title

	BFM_GETCURSORINFO						                    = C4D_FOUR_BYTE("cinf"),	// ask for mousepointdata, gibt Container zurueck
	//BFM_DRAG_SCREENX - screenx
	//BFM_DRAG_SCREENY - screeny
	// resultcontainer
	RESULT_CURSOR								                = 1,	// cursortype
	RESULT_BUBBLEHELP						                    = 2,	// bubblehelptext
	RESULT_SUPPRESSBUBBLE				                        = 3,
	RESULT_CURSOR_FORCE_HIDE		                            = 4,
	RESULT_CURSOR_NO_STEREO_HIDE                                = 5,
	RESULT_HELP1								                = 10,
	RESULT_HELP2								                = 11,
	RESULT_HELP3								                = 12,
	RESULT_HELP4								                = 13,
	RESULT_BUBBLEHELP_TITLE			                            = 20,			// bubblehelptext title (printed in bold for the bubblehelp. in the statusbar it's not visible)

	BFM_CURSORINFO_REMOVE				                        = C4D_FOUR_BYTE("cirm"),	// cursorinfo removed
	BFM_SETCURSORINFO						                    = C4D_FOUR_BYTE("setc"),
	BFM_GETINFO									                = C4D_FOUR_BYTE("bInf"),

	BFM_DRAW										            = C4D_FOUR_BYTE("bDRA"),
	BFM_DRAW_LEFT								                = 1,				// only redraw this area
	BFM_DRAW_TOP								                = 2,				// only redraw this area
	BFM_DRAW_RIGHT							                    = 3,				// only redraw this area
	BFM_DRAW_BOTTOM							                    = 4,				// only redraw this area
	BFM_DRAW_HASRECT						                    = 5,				// flag for a existing redraw rectangle
	BFM_DRAW_OGL								                = 6,				// flag for a existing redraw rectangle
	BFM_DRAW_REASON							                    = 7,				// message which started the redraw

	BFM_SHOW_AREA								                = C4D_FOUR_BYTE("sare"),	// scrolls the given rectangle visible (ScrollArea)
	//BFM_DRAW_LEFT
	//BFM_DRAW_TOP
	//BFM_DRAW_RIGHT
	//BFM_DRAW_BOTTOM

	BFM_SCROLLGROUP_SCROLLED					                = C4D_FOUR_BYTE("scrs"),
	SCROLLGROUP_HEADER								            = 0xdeadbeee,

	BFM_TITLECHNG											    = C4D_FOUR_BYTE("bTIC"),

	BFM_ENABLE												    = C4D_FOUR_BYTE("bEna"),	// enables the coffeeframe
	BFM_DISABLE												    = C4D_FOUR_BYTE("bDis"),	// disables the coffeeframe

	BFM_MINCHNG												    = C4D_FOUR_BYTE("bMIC"),

	BFM_MAXCHNG												    = C4D_FOUR_BYTE("bMAC"),

	BFM_VALUECHNG											    = C4D_FOUR_BYTE("bVAC"),

	BFM_IDCHNG												    = C4D_FOUR_BYTE("bIDC"),

	BFM_GOTFOCUS											    = C4D_FOUR_BYTE("bGFC"),	// Item gots the focus
	BFM_LOSTFOCUS											    = C4D_FOUR_BYTE("bLFC"),	// Item lost the focus

	BFM_SETFOCUS											    = C4D_FOUR_BYTE("bSFC"),	// internal msg
	BFM_SETFIRSTFOCUS									        = C4D_FOUR_BYTE("bSFF"),	// help message focus-keyboard-control

	BFM_MOVEFOCUSNEXT									        = C4D_FOUR_BYTE("bFNX"),	// help message focus-keyboard-control
	BFM_MOVEFOCUSPREV									        = C4D_FOUR_BYTE("bFPR"),	// help message focus-keyboard-control

	BFM_SETLASTFOCUS									        = C4D_FOUR_BYTE("bSLF"),	// help message focus-keyboard-control

	BFM_SHOW_FRAME										        = C4D_FOUR_BYTE("sFrm"),	// brings the frame to front, return true if found
	BFM_SHOW_ID												    = 1,			// show this id
	BFM_MANAGER_ID										        = 2,			// show this id

	BFM_CHILD_REMOVED									        = C4D_FOUR_BYTE("bRem"),
	BFM_CHILD_ID											    = 1,

	BFM_ACTIVATE_WINDOW								            = C4D_FOUR_BYTE("wact"),

	BFM_INPUT													= C4D_FOUR_BYTE("bIPN"),
	BFM_INPUT_QUALIFIER								            = C4D_FOUR_BYTE("ipqa"),	// Qualifier
	BFM_INPUT_MODIFIERS								            = C4D_FOUR_BYTE("ipmo"),	// all modifier states
	BFM_INPUT_DEVICE									        = C4D_FOUR_BYTE("ipdv"),	// Device
	BFM_INPUT_MOUSE										        = C4D_FOUR_BYTE("mous"),	// Mouse
	BFM_INPUT_KEYBOARD								            = C4D_FOUR_BYTE("keyb"),	// Mouse
	BFM_INPUT_ASC											    = C4D_FOUR_BYTE("kasc"),	//

	BFM_INPUT_CHANNEL									        = C4D_FOUR_BYTE("ipca"),	// Channel
	BFM_INPUT_MOUSELEFT								            = 1,
	BFM_INPUT_MOUSERIGHT							            = 2,
	BFM_INPUT_MOUSEMIDDLE							            = 3,
	BFM_INPUT_MOUSEX1									        = 5,
	BFM_INPUT_MOUSEX2									        = 6,
	BFM_INPUT_MOUSEWHEEL							            = 100,		// Windows-MouseWheelMessage
	BFM_INPUT_MOUSEMOVE								            = 101,		// Windows-MouseMoveMessage
	BFM_INPUT_VALUE										        = C4D_FOUR_BYTE("ipva"),	// Value des Channels (z.B Pressure)
	BFM_INPUT_VALUE_REAL							            = C4D_FOUR_BYTE("ipvA"),	// REAL: Value des Channels (z.B Pressure)
	BFM_INPUT_X												    = C4D_FOUR_BYTE("ipvx"),	// x-wert des Channels
	BFM_INPUT_Y												    = C4D_FOUR_BYTE("ipvy"),	// y-wert
	BFM_INPUT_Z												    = C4D_FOUR_BYTE("ipvz"),	// z-wert
	BFM_INPUT_TILT										        = C4D_FOUR_BYTE("itlt"),	// pen tilt
	BFM_INPUT_ORIENTATION							            = C4D_FOUR_BYTE("irot"),	// pen rotation, now called orientation
	BFM_INPUT_FINGERWHEEL							            = C4D_FOUR_BYTE("ifng"),	// finger wheel
	BFM_INPUT_P_ROTATION							            = C4D_FOUR_BYTE("prot"),	// real pen rotation (around own axis)

	BFM_INPUT_DOUBLECLICK							            = C4D_FOUR_BYTE("ipdb"),	// bool: doubleclick
	INPUT_DBLCLK											    = 0x8000,

	BFM_SIZED													= C4D_FOUR_BYTE("bISI"),

	BFM_ACTION												    = C4D_FOUR_BYTE("bACT"),
	BFM_ACTION_ID											    = C4D_FOUR_BYTE("meid"),
	BFM_ACTION_VALUE									        = C4D_FOUR_BYTE("meva"),
	BFM_ACTION_INDRAG									        = C4D_FOUR_BYTE("medr"),	// Bool: Slider in dragging mode (not finished)
	BFM_ACTION_STRCHG									        = C4D_FOUR_BYTE("mest"),	// Bool: String in Textfield changed
	BFM_ACTION_VALCHG									        = C4D_FOUR_BYTE("vchg"),	// Bool: NumberEdit/SliderChg
	BFM_ACTION_ESC										        = C4D_FOUR_BYTE("aesc"),	// action escaped
	BFM_ACTION_RESET									        = C4D_FOUR_BYTE("ares"),	// action escaped
	BFM_ACTION_UPDATE									        = C4D_FOUR_BYTE("updt"),	// update without verify

	BFM_COLORCHOOSER_PARENTMESSAGE		                        = C4D_FOUR_BYTE("colP"),
	BFM_COLORCHOOSER									        = C4D_FOUR_BYTE("colC"),
	BFM_COLORCHOOSER_SYSTEM						                = 1,
	BFM_COLORCHOOSER_RGB_RANGE				                    = 2,
	BFM_COLORCHOOSER_H_RANGE					                = 3,
	BFM_COLORCHOOSER_SV_RANGE					                = 4,
	BFM_COLORCHOOSER_SYSTEMMESSAGE		                        = 5,	// sends a parent message "BFM_COLORCHOOSER_PARENTMESSAGE" if settings change
	BFM_COLORCHOOSER_QUICKSTORE				                    = 6,
	BFM_COLORCHOOSER_MIXINGPANEL			                    = 7,

	BFM_GET_FOCUS_RECTANGLE						                = C4D_FOUR_BYTE("gfRc"),
	BFM_GET_FOCUS_RECTANGLE_X					                = 0,
	BFM_GET_FOCUS_RECTANGLE_Y					                = 1,
	BFM_GET_FOCUS_RECTANGLE_W					                = 2,
	BFM_GET_FOCUS_RECTANGLE_H					                = 3,

	BFM_ACTIVE_CHG										        = C4D_FOUR_BYTE("bACG"),	// Activation changed
	BFM_ACTIVE												    = C4D_FOUR_BYTE("actv"),	// Flag, if window is active

	BFM_DRAGSTART											    = 10001,
	BFM_DRAGRECEIVE										        = 10003,
	BFM_DRAGEND												    = 10004,
	BFM_DRAGAUTOSCROLL								            = 10005,

	DRAGTYPE_FILES										        = 1,	// DataPointer is a string with the filename
	DRAGTYPE_ICON											    = 4,	//
	DRAGTYPE_MANAGER									        = 5,	// destination-drag for coffeemanager
	DRAGTYPE_COMMAND									        = 6,	// destination-drag for command
	DRAGTYPE_CMDPALETTE								            = 7,

	DRAGTYPE_DESCID										        = 113,

	DRAGTYPE_ATOMARRAY								            = 201,
	DRAGTYPE_FILENAME_IMAGE						                = 202,
	DRAGTYPE_RGB											    = 203,
	DRAGTYPE_FILENAME_SCENE						                = 204,
	DRAGTYPE_FILENAME_OTHER						                = 205,

	DRAGTYPE_BROWSER_SCENE						                = 401,
	DRAGTYPE_BROWSER_MATERIAL					                = 402,
	DRAGTYPE_BROWSER_SOUND						                = 403,
	DRAGTYPE_BROWSER_FCV							            = 404,
	DRAGTYPE_BROWSER_COFFEE						                = 405,

	BFM_DRAG_DATA_										        = 2,
	BFM_DRAG_SCREENX									        = 3,
	BFM_DRAG_SCREENY									        = 4,
	BFM_DRAG_FINISHED									        = 5,
	BFM_DRAG_PRIVATE									        = 6,
	BFM_DRAG_LOST											    = 7,
	BFM_DRAG_TYPE_NEW									        = 8,
	BFM_DRAG_DATA_NEW									        = 9,
	BFM_DRAG_ESC											    = 10,

	AUTOSCROLL_UP											    = 1,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_DOWN										        =	2,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_LEFT										        = 3,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_RIGHT									        =	4,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_LEFT_UP								            = 7,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_LEFT_DOWN							            = 8,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_RIGHT_UP								            =	9,	// result of BFM_DRAGAUTOSCROLL
	AUTOSCROLL_RIGHT_DOWN							            =	10,	// result of BFM_DRAGAUTOSCROLL

	HANDLEMOUSEDRAG_PRIVATEFRAME			                    = 1,
	HANDLEMOUSEDRAG_PRIVATEAUTOSCROLL	                        = 2,

	// Tilo changed
	BFM_GETVALUE					                            = C4D_FOUR_BYTE("gVAL"),	// get Value

	BFM_VALUEADD					                            = C4D_FOUR_BYTE("bVAD"),
	BFM_VALUESUB					                            = C4D_FOUR_BYTE("bVSB"),

	BFM_INITVALUES				                                = C4D_FOUR_BYTE("bVIN"),

	BFM_ADJUSTSIZE				                                = C4D_FOUR_BYTE("fADJ"),	// message to adjust the object in the given range l.d.
	BFM_ADJUSTSIZE_LEFT		                                    = 1,
	BFM_ADJUSTSIZE_TOP		                                    = 2,
	BFM_ADJUSTSIZE_WIDTH	                                    = 3,
	BFM_ADJUSTSIZE_HEIGHT	                                    = 4,

	// ParentMessages
	//	BFM_GETDISABLED			                                = C4D_FOUR_BYTE("bDIS"),	// ask parents, if they are disables

	BFM_LAYOUT_CHANGED						                    = C4D_FOUR_BYTE("fLAY"),	// Message to parent about layout changes

	BFM_FULLSCREENMODE_ON					                    = C4D_FOUR_BYTE("ful1"),
	BFM_FULLSCREENMODE_OFF				                        = C4D_FOUR_BYTE("ful0"),

	BFM_ISACTIVE									            = C4D_FOUR_BYTE("iact"),	// for asking active view ...

	BFM_SETSTATUSBAR							                = C4D_FOUR_BYTE("stat"),
	BFM_STATUSBAR_PROGRESSON			                        = 1,				// bool
	BFM_STATUSBAR_TXT							                = 2,				// string
	BFM_STATUSBAR_PROGRESS				                        = 3,				// real 0.0...1.0
	BFM_STATUSBAR_PROGRESSSPIN		                            = 4,				// ...
	BFM_STATUSBAR_HELP						                    = 5,
	BFM_STATUSBAR_PROGRESSFULLSIZE                              = 6,				// use full-sized progress bar
	BFM_STATUSBAR_TINT_COLOR			                        = 7,				// Int32 colorid, Vector rgbvalue 0...1
	BFM_STATUSBAR_NETTINT_COLOR		                            = 8,				// Int32 colorid, Vector rgbvalue 0...1
	BFM_STATUSBAR_NETPROGRESSON		                            = 9,				// bool
	BFM_STATUSBAR_NETTXT					                    = 10,			// string
	BFM_STATUSBAR_NETPROGRESS			                        = 11,			// real 0.0...1.0
	BFM_STATUSBAR_NETPROGRESSSPIN	                            = 12,			// ...

	BFM_MARKFOCUS									            = C4D_FOUR_BYTE("bMFC"),	// reverts focus message ... for internal use only

	BFM_CLEARFOCUS								                = C4D_FOUR_BYTE("bCFC"),	// clear focus of all children

	BFM_SETACTIVE									            = C4D_FOUR_BYTE("bSAC"),	// SetActiveDialogBar
	BFM_SETACTIVE_DATA						                    = C4D_FOUR_BYTE("bSAC"),	// SetActiveDialogBar

	BFM_REMOVE_DIALOG							                = C4D_FOUR_BYTE("bREM"),	// remove the dialog from current group
	BFM_DESTINATION_GROUP					                    = C4D_FOUR_BYTE("gdst"),	// destination for dialog, nullptr means an own window

	BFM_SCROLLAREA								                = 10010,		// ScrollClientArea
	BFM_SCROLLX										            = 1,				// ScrollDirection
	BFM_SCROLLY										            = 2,				// ScrollDirection

	BFM_GETVISIBLE_XOFF						                    = 10011,		// internal usage
	BFM_GETVISIBLE_YOFF						                    = 10012,		// internal usage
	BFM_GETVISIBLE_WIDTH					                    = 10013,		// internal usage
	BFM_GETVISIBLE_HEIGHT					                    = 10014,		// internal usage

	// Scroller
	SCR_VISIBLEOBJS				                                = C4D_FOUR_BYTE("sVIS"),	// visible scroll elements

	BFM_SETVIEWPORTORIGIN	                                    = C4D_FOUR_BYTE("cORG"),
	BFM_SETVIEWPORTORIGIN_X                                     = 1,
	BFM_SETVIEWPORTORIGIN_Y                                     = 2,
	BFM_SETVIEWPORTSIZE		                                    = C4D_FOUR_BYTE("cSIZ"),

	BFM_MENU_SET					                            = 10000,
	BFM_MENU_ON						                            = 1,
	BFM_MENU_OFF					                            = 2,
	BFM_MENU_CHECK				                                = 4,
	BFM_MENU_UNCHECK			                                = 8,

	BFM_DRAWUSERITEM			                                = C4D_FOUR_BYTE("usrd"),
	BFM_DRAWUSERITEM_ID		                                    = 1,

	// Cinema-Message
	BFM_SYNC_MESSAGE							                = C4D_FOUR_BYTE("sync"),
	BFM_CORE_MESSAGE							                = C4D_FOUR_BYTE("MciM"),
	BFM_CORE_ID										            = C4D_FOUR_BYTE("MciI"),	// CinemaMessageID
	BFM_CORE_UNIQUEID							                = C4D_FOUR_BYTE("Muid"),	// TimeStamp
	BFM_CORE_PAR1									            = C4D_FOUR_BYTE("Mci1"),	// Parameter1
	BFM_CORE_PAR2									            = C4D_FOUR_BYTE("Mci2"),	// Parameter1
	BFM_CORE_SPECIALCOREID				                        = C4D_FOUR_BYTE("scid"),	// special managerid!!! for syncmessage

	BFM_TESTONLY									            = C4D_FOUR_BYTE("test"),	// do nothing
	BFM_SPECIALGETSTRING					                    = C4D_FOUR_BYTE("gtst"),	// special thing
	BFM_SPECIALSETRANGE						                    = C4D_FOUR_BYTE("srng"),	// special hack
	BFM_SPECIALMODE								                = C4D_FOUR_BYTE("srnm"),	// special hack
	BFM_SETSPECIALMULTI						                    = C4D_FOUR_BYTE("SSSS"),	// set passed setting to True (for MULTILINEEDIT)
	BFM_SETSPECIALMULTID					                    = C4D_FOUR_BYTE("SSSD"),	// set passed setting to False (for MULTILINEEDIT)

	BFM_POPUPNOTIFY								                = C4D_FOUR_BYTE("popn"),	// notify of popupbuttons before the menu opens

	BFM_INTERACTSTART							                = C4D_FOUR_BYTE("inta"),	// interact start notify
	BFM_INTERACTEND								                = C4D_FOUR_BYTE("inte"),	// interact end notify

	BFM_CORE_UPDATECOMMANDS				                        = C4D_FOUR_BYTE("updc"),	// updates all command buttons

	BF_INSERT_LAST								                = 2147483647,

	BFM_MENUFINDER								                = C4D_FOUR_BYTE("find"),
	BFM_SET_MSG_BITMASK						                    = C4D_FOUR_BYTE("bitm"),
	BITMASK_CORE_MESSAGE					                    = 1,
	BITMASK_SYNC_MESSAGE					                    = 2,

	BFM_SETMAINTITLE							                = C4D_FOUR_BYTE("mtit"),

	BFM_GETVIEWPANELDATA					                    = C4D_FOUR_BYTE("vpdt"),

	BFM_GETVIEWPANEL_PRIVATEDATA	                            = C4D_FOUR_BYTE("vppd"),
	BFM_SETVIEWPANELLAYOUT				                        = C4D_FOUR_BYTE("vpsl"),
	BFM_VPD_PANELID								                = C4D_FOUR_BYTE("vpid"),
	BFM_VPD_LAYOUTTYPE						                    = C4D_FOUR_BYTE("vplt"),
	BFM_VPD_MAXIMIZED							                = C4D_FOUR_BYTE("vpmx"),
	BFM_VPD_PRIVATEDATA						                    = C4D_FOUR_BYTE("vpdt"),

	BFM_STORE_WEIGHTS							                = C4D_FOUR_BYTE("stwg"),
	BFM_MARKFORCELAYOUT						                    = C4D_FOUR_BYTE("mkfl"),

	BFM_REDRAW_EDITMODE						                    = C4D_FOUR_BYTE("dwed"),
	BFM_RELOAD_MENUS							                = C4D_FOUR_BYTE("ldmn"),
	BFM_OPTIMIZE									            = C4D_FOUR_BYTE("opti"),
	BFM_CORE_UPDATEACTIVECOMMANDS                               = C4D_FOUR_BYTE("upda"),

	BFM_UPDATE_REGION							                = C4D_FOUR_BYTE("uprg"),	// ParentMessage -> UpdateRegion
	BFM_GUIPREFSCHANGED						                    = C4D_FOUR_BYTE("gpch"),	// Message for gui-prefs-changed
	BFM_COMMANDSCHANGED						                    = C4D_FOUR_BYTE("cmch"),	// Message for command-changed

	BFM_LAYOUT_GETDATA						                    = C4D_FOUR_BYTE("layg"),	// get layoutdata from manager
	BFM_LAYOUT_SETDATA						                    = C4D_FOUR_BYTE("lays"),	// set layoutdata in manager

	BFM_GETCUSTOMGUILAYOUTDATA		                            = C4D_FOUR_BYTE("layG"),	// get am layout data

	BFM_WEIGHTS_CHANGED						                    = C4D_FOUR_BYTE("wChg"),

	BFM_GETPARENT_MANAGER_ID			                        = C4D_FOUR_BYTE("gpid"),

	BFM_EDITFIELD_GETCURSORPOS		                            = C4D_FOUR_BYTE("getc"),
	BFM_EDITFIELD_GETBLOCKSTART		                            = C4D_FOUR_BYTE("getb"),
	BFM_EDITFIELD_SETCURSORPOS		                            = C4D_FOUR_BYTE("setc"),

	BFM_FADE											        = C4D_FOUR_BYTE("fade"),
	BFM_FADE_REMOVEALL						                    = C4D_FOUR_BYTE("FADE"),

	BFM_EDITFIELD_STOREUNDO				                        = C4D_FOUR_BYTE("stru"),	//Store the undo container for multiline edit text locally
	BFM_EDITFIELD_RESTOREUNDO			                        =	C4D_FOUR_BYTE("rstu"),	//Restore the undo container for multiline edit text from the local storage
	BFM_EDITFIELD_FLUSHUNDO				                        = C4D_FOUR_BYTE("flun"),	//Kill the undo stack for the multiline edit text
	BFM_EDITFIELD_GETUNDOSTATS		                            =	C4D_FOUR_BYTE("unst"),	//Get the undo statistics for the multiline edit text
	BFM_EDITFIELD_UNDOSTAT_COUNT			                    =	1,		//The undo stack size Int32
	BFM_EDITFIELD_UNDOSTAT_UNDOLEVEL	                        =	2,		//The current undo level Int32

	BFM_REQUIRESRESULT						                    = C4D_FOUR_BYTE("reqr"), //Set to true in the passed container for GeDialog::SendMessage to return a value from the message

	BFM_DUMMY											        = 0	// dummy without comma :-)
};

static assert(BFM_ACTION == 0x62414354);
static assert(BFM_INTERACTSTART == 0x696E7461);

enum
{
	GUI_DIALOG_MINIMIZE = 1000,
	GUI_DIALOG_RELEASE	= 1001,
	GUI_DIALOG_CLOSE		= 1002
};

