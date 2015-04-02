
module c4d_gui;


public import c4d;
public import c4d_os;
public import c4d_prepass;
public import c4d_string;
public import c4d_general;

public import c4d_colors;

public import gui;



enum
{
	FORMAT_FLOAT	 = C4D_FOUR_BYTE("frea"),
	FORMAT_INT		 = C4D_FOUR_BYTE("flng"),
	FORMAT_PERCENT	 = C4D_FOUR_BYTE("fpct"),
	FORMAT_DEGREE	 = C4D_FOUR_BYTE("fdgr"),
	FORMAT_METER	 = C4D_FOUR_BYTE("fmet"),
	FORMAT_FRAMES	 = C4D_FOUR_BYTE("ffrm"),
	FORMAT_SECONDS	 = C4D_FOUR_BYTE("fsec"),
	FORMAT_SMPTE	 = C4D_FOUR_BYTE("fsmp")
};

enum
{
	CM_DISABLED			= C4D_FOUR_BYTE("disb"),
	CM_TYPE_BUTTON		= C4D_FOUR_BYTE("bttn"),
	CM_TYPE_STRING		= C4D_FOUR_BYTE("strg"),
	CM_STRING			= C4D_FOUR_BYTE("strg"),
	CM_TYPE_DATA		= C4D_FOUR_BYTE("vdat"),
	CM_TYPE_INT			= C4D_FOUR_BYTE("vint"),
	CM_TYPE_FLOAT		= C4D_FOUR_BYTE("vflt"),
	CM_VALUE_VAL		= C4D_FOUR_BYTE("valu"),	// necessary
	CM_VALUE_MIN		= C4D_FOUR_BYTE("mini"),	// unnecessary
	CM_VALUE_MAX		= C4D_FOUR_BYTE("maxi"),	// unnecessary
	CM_VALUE_MIN2		= C4D_FOUR_BYTE("min2"), // for second range of slider with ints
	CM_VALUE_MAX2		= C4D_FOUR_BYTE("max2"), // for second range of slider with ints
	CM_VALUE_STEP		= C4D_FOUR_BYTE("step"),	// unnecessary
	CM_VALUE_FORMAT		= C4D_FOUR_BYTE("frmt"),	// unnecessary
	CM_VALUE_QUADSCALE	= C4D_FOUR_BYTE("quad"),	// quadscale of the slider
	CM_VALUE_TRISTATE	= C4D_FOUR_BYTE("tris"),	// 0 == off, 1 == enabled/even values 2 == enabled/different values
	CM_VALUE_FPS		= C4D_FOUR_BYTE("ffps")	// for FORMAT_FRAMES, FORMAT_SECONDS, FORMAT_SMPTE
};

// for popupcreation
enum FIRST_POPUP_ID = (900000);

enum IDM_CM_CLOSEWINDOW = 12097;

enum MAXTIME	=	108000;	// maximum time value equal 1.0 hours at 30fps //x2.77x hours!

enum COREMSG_CINEMA_GETCOMMANDNAME =		200000033;
enum COREMSG_CINEMA_GETCOMMANDENABLED =		200000035;
enum COREMSG_CINEMA_GETCOMMANDCHECKED =		300000115;
enum COREMSG_CINEMA_EXECUTEEDITORCOMMAND =  200000023;
enum COREMSG_CINEMA_EXECUTESUBID =			300001036;
enum COREMSG_CINEMA_EXECUTEOPTIONMODE =		300001037;
enum COREMSG_CINEMA_GETCOMMANDHELP =		200000234;

enum COREMSG_CINEMA_FORCE_AM_UPDATE		= 1001077;	// CoreMesage: Force AM update
enum COREMSG_UPDATECOMMANDSMESSAGE		= 200000100;

enum C4DGUIPTR		=	(-1);
enum C4DGUINOPTR	=	(-2);

enum GUI_MAXRANGE =	( 1.0e18);
enum GUI_MINRANGE =	(-1.0e18);

//extern (C++): //TODO 
//extern (C++) {

//=============================================================================
struct C4DGadget
{
public:
};


//=============================================================================
struct GadgetPtr
{
	Int32	   _id = C4DGUIPTR;
	C4DGadget* gad = null;

public:
	this(Int32 t_id) { _id = t_id; gad = null; }
	this(C4DGadget* t_gad) { _id = C4DGUIPTR; gad = t_gad; }

	@property void fromInt32(Int32 t_id) { _id = t_id; gad = null; } // write property
	@property Int32 fromInt32() { return _id; } // write property
	alias fromInt32 this;

	//@property void fromC4DGadget(C4DGadget* t_gad) { _id = C4DGUIPTR; gad = t_gad; } // write property
	//alias fromC4DGadget this;

	/*void opCast(T)(T t) {
	   
	}*/
	void opAssign(Int32 t_id) { _id = t_id; gad = null; }
	void opAssign(C4DGadget* t_gad) { _id = C4DGUIPTR; gad = t_gad; }

	Int32 Id() const { return _id; };
	//const(C4DGadget)* Ptr() const { return gad; }
	void* Ptr() const { return cast(void*)gad; }
};

unittest
{
	void test_fn(in GadgetPtr gp){

	}
	
	//? test_fn(123);

	GadgetPtr gp;
	int i = gp;
	gp = 1;
}

alias OBSOLETE = UChar;

//=============================================================================
//extern (C++)
class GeUserArea
{
private:
	Bool	 owncu = false;
	CUserArea* cu  = null;
protected:
	GeDialog dlg = null; //GeDialog* dlg;
public:

	 this() { dlg = null; cu = null; owncu = false; }//GeUserArea();
	~this() { if(!owncu) C4DOS.Cu.Free(cu); dlg = null; cu = null; }//virtual ~GeUserArea();

	final CUserArea* Get() { return cu; }
	final void Set(CUserArea* t_cu) { cu = t_cu; owncu = true; }
	final GeDialog GetDialog() { return dlg; } //GeDialog* GetDialog() { return dlg; }


	// for overriding (for easy message handling) -------------------------------------------------
	Bool Init         (){ return true; }
	Bool InitValues   (){ return true; }
	Bool GetMinSize   (ref Int32  w, ref Int32  h){ return false; }
	void Sized        (Int32 w, Int32 h){ }
	OBSOLETE Draw     (Int32 x1, Int32 y1, Int32 x2, Int32 y2){ DrawSetPen(COLOR_BG); DrawRectangle(x1, y1, x2, y2); return 0; }
	void DrawMsg      (Int32 x1, Int32 y1, Int32 x2, Int32 y2, ref const BaseContainer  msg){ Draw(x1, y1, x2, y2); }
	Bool InputEvent   (ref const BaseContainer  msg){ return false; }
	Bool CoreMessage  (Int32 id, ref const BaseContainer msg){ return true; }
	void Timer        (ref const BaseContainer  msg){ }

	// for overriding (for special message handling)
	Int32 Message(ref const BaseContainer  msg, ref BaseContainer  result)
	{
		Int32 id;
		Int32 res = 0;

		/*
		Int32 msg_id = msg.GetId();
		char[] str = "1234".dup;
		str[3] = (msg_id & 0xff);
		str[2] = (msg_id >>  8) & 0xff;
		str[1] = (msg_id >> 16) & 0xff;
		str[0] = (msg_id >> 24) & 0xff;

		if(msg_id!=BFM_GETCURSORINFO){
			printf("U Message %x  %.*s >>> \n",msg_id,str.length,str.ptr);
		}
		*/

		switch (msg.GetId())
		{
			case BFM_INIT:
				Init();
				res = true;
				break;

			case BFM_INITVALUES:
				InitValues();
				res = true;
				break;

			case BFM_CALCSIZE:
				{
					Int32 w = 0, h = 0;
					if (GetMinSize(w, h))
						C4DOS.Cu.SetMinSize(cu, w, h);
					res = true;
					break;
				}

			case BFM_SIZED:
				Sized(GetWidth(), GetHeight());
				res = true;
				break;

			case BFM_DRAW:
				{
					Int32 xr1 = msg.GetInt32(BFM_DRAW_LEFT);
					Int32 yr1 = msg.GetInt32(BFM_DRAW_TOP);
					Int32 xr2 = msg.GetInt32(BFM_DRAW_RIGHT);
					Int32 yr2 = msg.GetInt32(BFM_DRAW_BOTTOM);
					DrawMsg(xr1, yr1, xr2, yr2, msg);
					res = true;
					break;
				}

			case BFM_INPUT:
				return InputEvent(msg);

			case BFM_TIMER_MESSAGE:
				Timer(msg);
				res = true;
				break;

			case BFM_SYNC_MESSAGE:
			case BFM_CORE_MESSAGE:
				id = msg.GetInt32(BFM_CORE_ID);
				return CoreMessage(id, msg);

			default:
				break;

		}
		return res;
	}


final:	/// functions to call -------------------------------------------------------------------------


	void Redraw(Bool threaded = false) {
		if (dlg) {
			if (threaded) {
				C4DOS.Cd.SendRedrawThread(dlg.Get(), GetId());
			} else {
				dlg.SendMessage(GadgetPtr(GetId()), BaseContainer(BFM_DRAW));
			}
		}
	}
	Bool SendParentMessage()(auto ref const BaseContainer msg)	{
		C4DOS.Cu.SendParentMessage(cu, cast(BaseContainer*)&msg);
		return true;
	}

	Int32 GetWidth() { return C4DOS.Cu.GetWidth(cu); }
	Int32 GetHeight() { return C4DOS.Cu.GetHeight(cu); }
	Int32 GetId() { return C4DOS.Cu.GetID(cu); }
	
	Bool IsEnabled() { return C4DOS.Cu.IsEnabled(cu); }
	
	Bool HasFocus() { return C4DOS.Cu.HasFocus(cu); }
	
	void DrawBezier(Float sx, Float sy, Float *p, Int32 count,
								Bool closed, Bool filled) {
	  C4DOS.Cu.DrawBezier(cu, sx, sy, p, count, closed, filled);
	}
	
	void DrawLine(Int32 x1, Int32 y1, Int32 x2, Int32 y2) {
	  C4DOS.Cu.DrawLine(cu, x1, y1, x2, y2);
	}
	
	void DrawRectangle(Int32 x1, Int32 y1, Int32 x2, Int32 y2) {
	  C4DOS.Cu.DrawRectangle(cu, x1, y1, x2, y2);
	}
	
	void DrawSetPen(ref const GeData  d) {
	  if (d.GetType() == DA_VECTOR)
		DrawSetPen(d.GetVector());
	  else if (d.GetType() == DA_LONG)
		DrawSetPen(d.GetInt32());
	  else
		CriticalStop();
	}
	
	void DrawSetPen(ref const Vector  color) {
	  C4DOS.Cu.DrawSetPenV(cu, color);
	}
	
	void DrawSetPen(Int32 id) { C4DOS.Cu.DrawSetPenI(cu, id); }
	
	Bool GetColorRGB(Int32 colorid, ref Int32  r, ref Int32  g,
								 ref Int32  b) {
	  return C4DOS.Cd.CBF_GetColorRGB(cast(CBaseFrame *)cu, colorid, r, g, b);
	}
	
	void ActivateFading(Int32 milliseconds) {
	  C4DOS.Cd.CBF_ActivateFading(cast(CBaseFrame *)cu, milliseconds);
	}
	
	void AdjustColor(Int32 colorid, Int32 highlightid,
								 Float percent) {
	  C4DOS.Cd.CBF_AdjustColor(cast(CBaseFrame *)cu, colorid, highlightid,
								percent);
	}
	
	Bool IsHotkeyDown(Int32 id) {
	  return C4DOS.Cu.IsHotkeyDown(cu, id);
	}
	
	void GetBorderSize(Int32 type, Int32 *l, Int32 *t, Int32 *r,
								   Int32 *b) {
	  C4DOS.Cu.GetBorderSize(cu, type, l, t, r, b);
	}
	
	void DrawBorder(Int32 type, Int32 x1, Int32 y1, Int32 x2,
								Int32 y2) {
	  C4DOS.Cu.DrawBorder(cu, type, x1, y1, x2, y2);
	}
	
	void SetTimer(Int32 timer) {
	  C4DOS.Cu.SetTimer(cu, timer);
	}
	
	Bool GetInputState(Int32 askdevice, Int32 askchannel,
								   ref BaseContainer  res) {
	  return C4DOS.Cu.GetInputState(cast(CBaseFrame *)cu, askdevice,
									 askchannel, &res);
	}
	
	Bool GetInputEvent(Int32 askdevice, ref BaseContainer  res) {
	  return C4DOS.Cu.GetInputEvent(cast(CBaseFrame *)cu, askdevice, &res);
	}
	
	void KillEvents() {
	  C4DOS.Cu.KillEvents(cast(CBaseFrame *)cu);
	}

	Bool CheckDropArea(ref const BaseContainer  msg, Bool horiz, Bool vert)
	{
		Int32 x = 0, y = 0, w, h, dx, dy;

		dlg.GetDragPosition(msg, &dx, &dy);
		dlg.GetItemDim(GetId(), &x, &y, &w, &h);

		if (horiz && vert)
			return dx > x && dx < x + w && dy > y && dy < y + h;
		else if (vert)
			return dy > y && dy < y + h;
		return dx > x && dx < x + w;
	}

	void DrawSetFont(Int32 fontid)
	{
		C4DOS.Cu.DrawSetFont(cu, fontid);
	}

	Int32 DrawGetTextWidth(ref const String  text)
	{
		return C4DOS.Cu.DrawGetTextWidth(cu, cast(String*)&text);
	}

	Int32 DrawGetTextWidth_ListNodeName(BaseList2D* node, Int32 fontid)
	{
		return C4DOS.Cu.DrawGetTextWidth_ListNodeName(cu, node, fontid);
	}

	void DrawSetTextRotation(Float textrotation)
	{
		C4DOS.Cu.DrawSetTextRotation(cu, textrotation);
	}

	Int32 DrawGetFontHeight()
	{
		return C4DOS.Cu.DrawGetFontHeight(cu);
	}

	Int32 DrawGetFontBaseLine()
	{
		return C4DOS.Cu.DrawGetFontBaseLine(cu);
	}

	void DrawSetTextCol(Int32 fg, Int32 bg)
	{
		C4DOS.Cu.DrawSetTextColII(cu, fg, bg);
	}

	void DrawSetTextCol(ref const Vector  fg, Int32 bg)
	{
		C4DOS.Cu.DrawSetTextColVI(cu, fg, bg);
	}

	void DrawSetTextCol(Int32 fg, ref const Vector  bg)
	{
		C4DOS.Cu.DrawSetTextColIV(cu, fg, bg);
	}

	void DrawSetTextCol(ref const Vector  fg, ref const Vector  bg)
	{
		C4DOS.Cu.DrawSetTextColVV(cu, fg, bg);
	}

	void DrawSetTextCol(ref const GeData  fg, ref const GeData  bg)
	{
		if (fg.GetType() == DA_VECTOR)
		{
			if (bg.GetType() == DA_VECTOR)
				C4DOS.Cu.DrawSetTextColVV(cu, fg.GetVector(), bg.GetVector());
			else if (bg.GetType() == DA_LONG)
				C4DOS.Cu.DrawSetTextColVI(cu, fg.GetVector(), bg.GetInt32());
			else
				CriticalStop();
		}
		else if (fg.GetType() == DA_LONG)
		{
			if (bg.GetType() == DA_VECTOR)
				C4DOS.Cu.DrawSetTextColIV(cu, fg.GetInt32(), bg.GetVector());
			else if (bg.GetType() == DA_LONG)
				C4DOS.Cu.DrawSetTextColII(cu, fg.GetInt32(), bg.GetInt32());
			else
				CriticalStop();
		}
		else
		{
			CriticalStop();
		}
	}

	void DrawText(ref const String  txt, Int32 x, Int32 y, Int32 flags)
	{
		C4DOS.Cu.DrawText(cu, txt, x, y, flags);
	}

	void DrawBitmap(BaseBitmap* bmp, Int32 wx, Int32 wy, Int32 ww, Int32 wh, Int32 x, Int32 y, Int32 w, Int32 h, Int32 mode)
	{
		C4DOS.Cu.DrawBitmap(cu, bmp, wx, wy, ww, wh, x, y, w, h, mode);
	}

	void SetClippingRegion(Int32 x, Int32 y, Int32 w, Int32 h)
	{
		C4DOS.Cu.SetClippingRegion(cu, x, y, w, h);
	}

	void ClearClippingRegion()
	{
		C4DOS.Cu.ClearClippingRegion(cu);
	}

	Bool OffScreenOn()
	{
		return C4DOS.Cu.OffScreenOn(cu);
	}

	Bool OffScreenOn(Int32 x, Int32 y, Int32 w, Int32 h)
	{
		return C4DOS.Cu.OffScreenOnRect(cu, x, y, w, h);
	}

	void ScrollArea(Int32 xdiff, Int32 ydiff, Int32 x, Int32 y, Int32 w, Int32 h)
	{
		C4DOS.Cu.ScrollArea(cu, xdiff, ydiff, x, y, w, h);
	}
static if(API_VERSION >= 15000) { //R15 only
	Float GetPixelRatio() const	{
		if (!cu) return 1.0;
		return C4DOS.Cu.GetPixelRatio(cast(const CBaseFrame*)cu);
	}
}
	Bool Global2Local(Int32* x, Int32* y)
	{
		return C4DOS.Cu.Global2Local(cast(CBaseFrame*)cu, x, y);
	}

	Bool Local2Global(Int32* x, Int32* y)
	{
		return C4DOS.Cu.Local2Global(cast(CBaseFrame*)cu, x, y);
	}

	Bool Local2Screen(Int32* x, Int32* y)
	{
		return C4DOS.Cu.Local2Screen(cast(CBaseFrame*)cu, x, y);
	}

	Bool Screen2Local(Int32* x, Int32* y)
	{
		return C4DOS.Cu.Screen2Local(cast(CBaseFrame*)cu, x, y);
	}

	void FillBitmapBackground(BaseBitmap* bmp, Int32 offsetx, Int32 offsety)
	{
		DrawBitmap(bmp, -0x12345, -0x12345, -0x12345, -0x12345, offsetx, offsety, -0x12345, -0x12345, -0x12345);
	}

	void LayoutChanged(){
		SendParentMessage(BaseContainer(BFM_LAYOUT_CHANGED));
	}

/+
	// functions to call
	void Redraw               (Bool threaded = false);
	Bool SendParentMessage    (const BaseContainer& msg);

	Int32 GetId                ();
	Int32 GetWidth             ();
	Int32 GetHeight            ();
	Bool IsEnabled			   ();
	Bool HasFocus			   ();

	// input events and tTimer
	void SetTimer             (Int32 timer);
	Bool GetInputState        (Int32 askdevice, Int32 askchannel, BaseContainer& res);
	Bool GetInputEvent        (Int32 askdevice, BaseContainer& res);
	void KillEvents           ();
	Bool IsHotkeyDown					(Int32 id);

	// pens
	void DrawSetPen           (const Vector& color);
	void DrawSetPen           (Int32 id);
	void DrawSetPen           (const GeData& d);
	void DrawSetTextCol       (Int32 fg, Int32 bg);
	void DrawSetTextCol       (const Vector& fg, Int32 bg);
	void DrawSetTextCol       (Int32 fg, const Vector& bg);
	void DrawSetTextCol       (const Vector& fg, const Vector& bg);
	void DrawSetTextCol       (const GeData& fg, const GeData& bg);
	Bool GetColorRGB          (Int32 colorid, Int32& r, Int32& g, Int32& b);
	void ActivateFading				(Int32 milliseconds);
	void AdjustColor					(Int32 colorid, Int32 highlightid, Float percent);

	// draw functions
	void DrawLine             (Int32 x1, Int32 y1, Int32 x2, Int32 y2);
	void DrawRectangle        (Int32 x1, Int32 y1, Int32 x2, Int32 y2);
	void DrawBitmap           (BaseBitmap* bmp, Int32 wx, Int32 wy, Int32 ww, Int32 wh, Int32 x, Int32 y, Int32 w, Int32 h, Int32 mode);
	#define	DRAWTEXT_HALIGN_LEFT	 0
	#define	DRAWTEXT_HALIGN_CENTER 1
	#define	DRAWTEXT_HALIGN_RIGHT	 2
	#define	DRAWTEXT_HALIGN_MASK	 0x000f
	#define	DRAWTEXT_VALIGN_TOP		 (0 << 4)
	#define	DRAWTEXT_VALIGN_CENTER (1 << 4)
	#define	DRAWTEXT_VALIGN_BOTTOM (2 << 4)
	#define	DRAWTEXT_VALIGN_MASK	 0x00f0
	#define	DRAWTEXT_STD_ALIGN		 (DRAWTEXT_HALIGN_LEFT | DRAWTEXT_VALIGN_TOP)
	void DrawText             (const String& txt, Int32 x, Int32 y, Int32 flags = DRAWTEXT_STD_ALIGN);
	#define DRAWBEZIER_BX	0
	#define DRAWBEZIER_BY	1
	#define DRAWBEZIER_CX	2
	#define DRAWBEZIER_CY	3
	#define DRAWBEZIER_DX	4
	#define DRAWBEZIER_DY	5
	void DrawBezier						(Float sx, Float sy, Float* p, Int32 len, Bool closed, Bool filled);
	void FillBitmapBackground (BaseBitmap* bmp, Int32 offsetx, Int32 offsety);

	// fonts
	void DrawSetFont          (Int32 fontid);
	Int32 DrawGetTextWidth     (const String& text);
	Int32 DrawGetTextWidth_ListNodeName(BaseList2D* node, Int32 fontid = FONT_STANDARD);
	Int32 DrawGetFontHeight    ();
	Int32 DrawGetFontBaseLine	();
	void DrawSetTextRotation	(Float textrotation);	// degree, cw, dont forget to reset it to 0 afterwards

	// others
	void SetClippingRegion    (Int32 x, Int32 y, Int32 w, Int32 h);
	void ClearClippingRegion  ();
	Bool OffScreenOn          ();
	Bool OffScreenOn					(Int32 x, Int32 y, Int32 w, Int32 h);
	void ScrollArea           (Int32 xdiff, Int32 ydiff, Int32 x, Int32 y, Int32 w, Int32 h);

	Float GetPixelRatio        () const;
	Bool Local2Global         (Int32* x, Int32* y);
	Bool Global2Local         (Int32* x, Int32* y);
	Bool Local2Screen         (Int32* x, Int32* y);
	Bool Screen2Local         (Int32* x, Int32* y);

	void LayoutChanged        ();

	Bool GetDragPosition      (const BaseContainer& msg, Int32* x, Int32* y);
	Bool GetDragObject        (const BaseContainer& msg, Int32* type, void** object);
	Bool HandleMouseDrag      (const BaseContainer& msg, Int32 type, void* data, Int32 dragflags);
	Bool SetDragDestination   (Int32 cursor);
	void GetBorderSize        (Int32 type, Int32* l, Int32* t, Int32* r, Int32* b);
	void DrawBorder           (Int32 type, Int32 x1, Int32 y1, Int32 x2, Int32 y2);

	#ifdef __API_INTERN__
	Bool OpenPopUpMenu				(Int32 menuid, Int32 localx, Int32 localy, Int32 watchhotkey);
	#endif

	Bool CheckDropArea        (const BaseContainer& msg, Bool horiz, Bool vert);

	void MouseDragStart				(Int32 button, Float mx, Float my, MOUSEDRAGFLAGS flag);
	MOUSEDRAGRESULT MouseDrag	(Float* mx, Float* my, BaseContainer* channels);
	MOUSEDRAGRESULT MouseDragEnd();

	Bool IsR2L                ();

	#define MOUSEMOVE_DELTA_TABLET 6.0
	#define MOUSEMOVE_DELTA_MOUSE	 2.0

	// LassoSelection is working with GeDialog & GeUserArea
+/
}; //GeUserArea



//--------------------------------------------------------------------------------
extern (C++)
Int32 CDialogCallBack(CDialog* cd, CUserArea* cu, BaseContainer* msg) //CDialogMessage
{
	Int32		  res = 0;
	BaseContainer result = NOTOK;
	if (cu) { /// UserAreaMessage
		//?GeUserArea* usr = cast(GeUserArea*)C4DOS.Cu.GetUserData(cu); //pointers to class are not allowed !!!
		GeUserArea usr = cast(GeUserArea)C4DOS.Cu.GetUserData(cu);
		if (!usr)	return false;
		//printf("UserAreaMessage %i \n",msg.GetId());

		//printf(" ptr cd=%p  cu=%p  %p \n",cd,cu,C4DOS.Cu.GetUserData(cu));
		/*
		Int32 msg_id = msg.GetId();
		char[] str = "1234".dup;
		str[3] = (msg_id & 0xff);
		str[2] = (msg_id >>  8) & 0xff;
		str[1] = (msg_id >> 16) & 0xff;
		str[0] = (msg_id >> 24) & 0xff;

		if(msg_id!=BFM_GETCURSORINFO){
			printf("UserAreaMessage %x  %.*s  %p >>> \n",msg_id,str.length,str.ptr,usr);
		}
		*/
		//return false; //! TEST ONLY !!!
		res = usr.Message(*msg, result); //<<< CRASH 
	}else{	/// DialogMessage
		//? GeDialog* dlg = cast(GeDialog*)C4DOS.Cd.GetUserData(cd); //pointers to class are not allowed !!!
		GeDialog dlg = cast(GeDialog)C4DOS.Cd.GetUserData(cd);
		if (!dlg)	return false;
		//printf("DialogMessage %i \n",msg.GetId());
		res = dlg.Message(*msg, result);
	}
	if (result.GetId() != NOTOK) {
		//printf("SetMessageResult %i \n",result.GetId(),NOTOK);
		C4DOS.Cd.SetMessageResult(cd, &result);
	}
	//printf(" res %i \n",res);
	return res;
}

//=============================================================================
//extern (C++)
class GeDialog
{
private:
	CDialog* cd = null;
	Int32	 t_lastcoremsg;
protected:
	Bool createlayout = false;

public:
	 this() { 
		cd = C4DOS.Cd.Alloc(&CDialogCallBack, /*cast(void*)*/this); //pointers to class are not allowed !!!
		createlayout = false;
	 } //GeDialog();
	~this() { if (cd){ C4DOS.Cd.Free(cd); } cd = null; } //virtual ~GeDialog();

	final CDialog* Get() { return cd; }

	// for overriding (for easy message handling)
	Bool CreateLayout () {  return true;	} // to override
	Bool InitValues   () {	return true;	} // to override
	Bool CoreMessage  (Int32 id,ref const BaseContainer msg) {	return true;	} // to override
	Bool Command      (Int32 id,ref const BaseContainer msg) {  return false;	} // to override
	Bool AskClose     () {	return false;	} // to override
	void Timer        (ref const BaseContainer msg){	}
	void DestroyWindow() {	}	// use this function to set all pointers to userareas/customgui elements to nullptr
	
	// for overriding (for special message handling)
	Int32 Message(ref const BaseContainer msg,ref BaseContainer result)
	{
		Int32 id=0;
		Int32 res=0;
		//static assert(BFM_ACTION == 0x62414354);
		//pragma(msg,BFM_ACTION_ID); //6433

		/+
		Int32 msg_id = msg.GetId();
		id = msg.GetInt32(BFM_CORE_ID);

		//if(msg_id==BFM_ACTION) printf("BFM_ACTION !!! \n");
		char[] str = "1234".dup;
		str[3] = (msg_id & 0xff);
		str[2] = (msg_id >>  8) & 0xff;
		str[1] = (msg_id >> 16) & 0xff;
		str[0] = (msg_id >> 24) & 0xff;
		//printf("Message %x  %.*s >>> \n",msg_id,str.length,str.ptr);
		//GePrint(string(str));

		if(msg_id!=BFM_GETCURSORINFO && msg_id!=BFM_CORE_MESSAGE){
			printf("D Message %x %i  %.*s >>> \n",msg_id,id,str.length,str.ptr);
		}
		+/

		switch (msg.GetId())
		{
			case BFM_INTERACTSTART:	// interact stop
				StopAllThreads();
				//return FALSE; //default do not block interactions 
				//return TRUE; //block all interactions !!!
				break;

			case BFM_INIT:
				if (createlayout)
					return true;
				createlayout = true;
				return CreateLayout();

			case BFM_DESTROY:
				DestroyWindow();
				createlayout = false;
				break;

			case BFM_INITVALUES:
				if (!createlayout)
					return true;
				return InitValues();

			case BFM_SYNC_MESSAGE:
				id = msg.GetInt32(BFM_CORE_ID);
				return CoreMessage(id, msg);

			case BFM_CORE_MESSAGE:
				id = msg.GetInt32(BFM_CORE_ID);
				return CoreMessage(id, msg);

			case BFM_ACTION:
				id	= msg.GetInt32(BFM_ACTION_ID);
				res = Command(id, msg);
				return res;

			case BFM_CHECKCLOSE:
				return AskClose();
				//break;

			case BFM_TIMER_MESSAGE:
				Timer(msg);
				return true;

			/*case BFM_INPUT: // 'bIPN', ///key board input !!!!
				{
					printf(" key ");
				} break;
			*/
			default: //if we remove this it will crash !!!
				//printf("Message %x >>> \n",msg.GetId());
				//printf("default \n");
				return false;	//return 0;
		}
		//printf("Message <<< \n");
		return false; //return 0;
	}


final:	/// functions to call -------------------------------------------------------------------------
	Bool Open(DLG_TYPE dlgtype, Int32 pluginid, Int32 xpos = -1, Int32 ypos = -1, Int32 defaultw = 0, Int32 defaulth = 0, Int32 subid = 0){
		if (!cd) return false;
		C4DOS.Cd.AddGadget(cd, DIALOG_SETIDS, pluginid, null, subid, 0, 0, 0, null, null);
		return C4DOS.Cd.Open(cd, dlgtype, null, xpos, ypos, defaultw, defaulth);
	}
	Bool Close(){
		if (!cd) return false;
		return C4DOS.Cd.Close(cd);
	}
	Bool Close(Bool dummy){
		return Close();
	}

	GeData SendMessage(in GadgetPtr id,in BaseContainer  msg) {
		if (!cd)	return GeData(false);
		return C4DOS.Cd.SendUserAreaMessage(cd, id.Id(), cast(BaseContainer*)&msg, cast(void*)id.Ptr());
	}

	Bool SendParentMessage(in BaseContainer msg) {
		return C4DOS.Cd.SendParentMessage(cd, &msg);
	}

/+
	GeData SendMessage()(auto ref const GadgetPtr id,auto ref const BaseContainer  msg) {
		if (!cd)	return GeData(false);
		return C4DOS.Cd.SendUserAreaMessage(cd, id.Id(), cast(BaseContainer*)&msg, cast(void*)id.Ptr());
	}

	Bool SendParentMessage()(auto ref const BaseContainer msg) {
		return C4DOS.Cd.SendParentMessage(cd, &msg);
	}
+/

	Int32 GetId()	{ return C4DOS.Cd.GetID(Get()); }
	Bool IsOpen()	{ return C4DOS.Cd.AddGadget(cd, DIALOG_ISOPEN, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr); }
	Bool IsVisible(){ return C4DOS.Cd.AddGadget(cd, DIALOG_ISVISIBLE, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr); }

	void SetTimer(Int32 timer){ C4DOS.Cd.SetTimer(cd, timer); }
	void SetTitle(ref const String title){ if (!cd) return;
		C4DOS.Cd.AddGadget(cd, DIALOG_SETTITLE, 0, cast(String*)&title, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool GetInputState(Int32 askdevice, Int32 askchannel, ref BaseContainer  res)	{
		return C4DOS.Cu.GetInputState(cast(CBaseFrame*)cd, askdevice, askchannel, &res);
	}

	Bool GetInputEvent(Int32 askdevice, ref BaseContainer  res)	{
		return C4DOS.Cu.GetInputEvent(cast(CBaseFrame*)cd, askdevice, &res);
	}

	void KillEvents() {	C4DOS.Cu.KillEvents(cast(CBaseFrame*)cd); }


	//groups 
	Bool TabGroupBegin(Int32 id, Int32 flags, Int32 tabtype = TAB_TABS) {
		if (!cd) return false;
		return C4DOS.Cd.TabGroupBegin(cd, id, flags, tabtype);
	}

	Bool GroupBegin()(Int32 id, Int32 flags, Int32 cols, Int32 rows,auto ref const String  title, Int32 groupflags, Int32 initw=0, Int32 inith=0)	{
		if (!cd) return false;
		return C4DOS.Cd.GroupBegin(cd, id, flags, cols, rows, cast(String*)&title, groupflags, initw, inith);
	}

	Bool GroupEnd()	{
		if (!cd) return false;
		return C4DOS.Cd.GroupEnd(cd);
	}

	Bool GroupBeginInMenuLine(){
		return C4DOS.Cd.AddGadget(Get(), DIALOG_MENUGROUPBEGIN, 0, null, 0, 0, 0, 0, null, null);
	}

	Bool Enable()(auto ref const GadgetPtr  id, Bool enabled) {
		if (!cd) return false;
		return C4DOS.Cd.Enable(cd, id.Id(), enabled, id.Ptr());
	}
	Bool Enable(int id , Bool enabled) {
		if (!cd) return false;
		return C4DOS.Cd.Enable(cd, id, enabled, null);
	}

	Bool IsEnabled(ref const GadgetPtr  id) {
		if (!cd) return false;
		return C4DOS.Cd.IsEnabled(cd, id.Id(), cast(void*)id.Ptr());
	}

	C4DGadget* AddButton()(Int32 id, Int32 flags, Int32 initw, Int32 inith,auto ref const String  name) {
		if (!cd) return null;
		void* r = null;
		C4DOS.Cd.AddGadget(cd, DIALOG_BUTTON, id, cast(String*)&name, flags, initw, inith, 0, null, &r);
		return cast(C4DGadget*)r;
	}

	/*void SetTitle()(auto ref const String title) {
		if (!cd) return;
		C4DOS.Cd.AddGadget(cd, DIALOG_SETTITLE, 0, cast(String*)&title, 0, 0, 0, 0, nullptr, nullptr);
	}*/
	void SetTitle(in String title) {
		if (!cd) return;
		C4DOS.Cd.AddGadget(cd, DIALOG_SETTITLE, 0, cast(String*)&title, 0, 0, 0, 0, nullptr, nullptr);
	}


	Bool RestoreLayout(Int32 pluginid, Int32 subid, void* secret){
		C4DOS.Cd.AddGadget(cd, DIALOG_SETIDS, pluginid, nullptr, subid, 0, 0, 0, nullptr, nullptr);
		return C4DOS.Cd.RestoreLayout(cd, secret);
	}

/+
	// functions to call


	// set/get functions
	Bool Enable               (const GadgetPtr& id, Bool enabled);
	Bool IsEnabled            (const GadgetPtr& id);
	Bool SetBool              (const GadgetPtr& id, Bool value, Int32 tristate = 0);
	Bool SetInt32             (const GadgetPtr& id, Int32 value, Int32 min = LIMIT!Int32.MIN, Int32 max = LIMIT!Int32.MAX, Int32 step = 1, Int32 tristate = 0, Int32 min2 = LIMIT!Int32.MIN, Int32 max2 = LIMIT!Int32.MAX);
	Bool SetFloat             (const GadgetPtr& id, Float value, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 format = FORMAT_FLOAT, Float min2 = 0.0, Float max2 = 0.0, Bool quadscale = false, Int32 tristate = 0);
	Bool SetMeter             (const GadgetPtr& id, Float value, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 tristate = 0);
	Bool SetDegree            (const GadgetPtr& id, Float radians_value, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 tristate = 0);
	Bool SetPercent           (const GadgetPtr& id, Float value, Float min = 0.0, Float max = 100.0, Float step = 1.0, Int32 tristate = 0);
	Bool SetTime							(const GadgetPtr& id, const BaseDocument* doc, const BaseTime& value, const BaseTime& min = BaseTime(-MAXTIME, 1), const BaseTime& max = BaseTime(MAXTIME, 1), Int32 stepframes = 1, Int32 tristate = 0);
	Bool SetString            (const GadgetPtr& id, const String& text, Int32 tristate = 0, Int32 flags = 0);
	Bool SetColorField        (const GadgetPtr& id, const Vector& color, Float brightness, Float maxbrightness, Int32 flags);
	Bool SetFilename          (const GadgetPtr& id, const Filename& fn, Int32 tristate = 0);

	Bool GetBool              (const GadgetPtr& id, Bool& value) const;
	Bool GetInt32              (const GadgetPtr& id, Int32& value) const;
	Bool GetFloat              (const GadgetPtr& id, Float& value) const;
	Bool GetVector            (const GadgetPtr& id_x, const GadgetPtr& id_y, const GadgetPtr& id_z, Vector& value) const;
	Bool GetString            (const GadgetPtr& id, String& text) const;
	Bool GetColorField        (const GadgetPtr& id, Vector& color, Float& brightness) const;
	Bool GetTime							(const GadgetPtr& id, const BaseDocument* doc, BaseTime& time) const;
	Bool GetFilename          (const GadgetPtr& id, Filename& fn) const;

	Bool CheckTristateChange	(const GadgetPtr& id);	// return wheter the gadget content has been changed since the last SetXXX or not

	// container set/get functions
	Bool SetBool              (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid);
	Bool SetInt32              (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Int32 min = LIMIT!Int32.MIN, Int32 max = LIMIT!Int32.MAX, Int32 step = 1, Int32 min2 = LIMIT!Int32.MIN, Int32 max2 = LIMIT!Int32.MAX);
	Bool SetFloat              (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 format = FORMAT_FLOAT, Float min2 = 0.0, Float max2 = 0.0, Bool quadscale = false);
	Bool SetMeter             (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0);
	Bool SetDegree            (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0);
	Bool SetPercent           (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Float min = 0.0, Float max = 100.0, Float step = 1.0);
	Bool SetTime							(const GadgetPtr& id, const BaseDocument* doc, const BaseContainer* bc, Int32 bcid, const BaseTime& min = BaseTime(-MAXTIME, 1), const BaseTime& max = BaseTime(MAXTIME, 1), Int32 stepframes = 1);

	Bool SetString            (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid, Int32 flags = 0);
	Bool SetFilename          (const GadgetPtr& id, const BaseContainer* bc, Int32 bcid);
	Bool SetColorField        (const GadgetPtr& id, const BaseContainer* bc, Int32 bc_colid, Int32 bc_brightnessid, Float maxbrightness, Int32 flags);

	Bool GetBool              (const GadgetPtr& id, BaseContainer* bc, Int32 bcid) const;
	Bool GetInt32              (const GadgetPtr& id, BaseContainer* bc, Int32 bcid) const;
	Bool GetFloat              (const GadgetPtr& id, BaseContainer* bc, Int32 bcid) const;
	Bool GetTime							(const GadgetPtr& id, const BaseDocument* doc, BaseContainer* bc, Int32 bcid) const;
	Bool GetVector            (const GadgetPtr& id_x, const GadgetPtr& id_y, const GadgetPtr& id_z, BaseContainer* bc, Int32 bcid) const;
	Bool GetString            (const GadgetPtr& id, BaseContainer* bc, Int32 bcid) const;
	Bool GetFilename          (const GadgetPtr& id, BaseContainer* bc, Int32 bcid) const;
	Bool GetColorField        (const GadgetPtr& id, BaseContainer* bc, Int32 bc_colid, Int32 bc_brightnessid) const;

	// set/get functions for tristates
	Bool SetBool              (const GadgetPtr& id, const TriState<Bool>& tri);
	Bool SetInt32              (const GadgetPtr& id, const TriState<Int32>& tri, Int32 min = LIMIT!Int32.MIN, Int32 max = LIMIT!Int32.MAX, Int32 step = 1, Int32 min2 = LIMIT!Int32.MIN, Int32 max2 = LIMIT!Int32.MAX);
	Bool SetFloat              (const GadgetPtr& id, const TriState<Float>& tri, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 format = FORMAT_FLOAT, Float min2 = 0.0, Float max2 = 0.0, Bool quadscale = false);
	Bool SetMeter             (const GadgetPtr& id, const TriState<Float>& tri, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0);
	Bool SetDegree            (const GadgetPtr& id, const TriState<Float>& tri, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0);
	Bool SetPercent           (const GadgetPtr& id, const TriState<Float>& tri, Float min = 0.0, Float max = 100.0, Float step = 1.0);
	Bool SetTime							(const GadgetPtr& id, const BaseDocument* doc, const TriState<BaseTime>& tri, const BaseTime& min = BaseTime(-MAXTIME, 1), const BaseTime& max = BaseTime(MAXTIME, 1), Int32 stepframes = 1);
	Bool SetString            (const GadgetPtr& id, const TriState<String>& tri, Int32 flags = 0);
	#define FLAG_CENTER_HORIZ	1
	#define FLAG_CENTER_VERT	2
	#define FLAG_ALIGN_RIGHT	4
	Bool SetMultiLinePos			(const GadgetPtr& id, Int32 line, Int32 pos);

	Bool SetColorField        (const GadgetPtr& id, const TriState<Vector>& tri, Float brightness, Float maxbrightness, Int32 flags);

	Bool CheckValueRanges     ();

	Float GetPixelRatio        () const;

	Bool Local2Global         (Int32* x, Int32* y);
	Bool Global2Local         (Int32* x, Int32* y);
	Bool Screen2Local					(Int32* x, Int32* y);
	Bool Local2Screen					(Int32* x, Int32* y);
	Bool GetColorRGB          (Int32 colorid, Int32& r, Int32& g, Int32& b);
	void SetDefaultColor			(const GadgetPtr& id, Int32 colorid, Int32 mapid);
	void SetDefaultColor			(const GadgetPtr& id, Int32 colorid, const Vector& color);

	// layout stuff
	Bool LoadDialogResource   (Int32 id, GeResource* lr, Int32 flags);

	C4DGadget* AddCheckbox          (Int32 id, Int32 flags, Int32 initw, Int32 inith, const String& name);
	C4DGadget* AddButton            (Int32 id, Int32 flags, Int32 initw, Int32 inith, const String& name);
	C4DGadget* AddStaticText        (Int32 id, Int32 flags, Int32 initw, Int32 inith, const String& name, Int32 borderstyle);
	C4DGadget* AddArrowButton       (Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 arrowtype);
	C4DGadget* AddEditText          (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Int32 editflags = 0);
	C4DGadget* AddMultiLineEditText (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Int32 style = 0);
	C4DGadget* AddEditNumber        (Int32 id, Int32 flags, Int32 initw = 80, Int32 inith = 0);
	C4DGadget* AddEditNumberArrows  (Int32 id, Int32 flags, Int32 initw = 70, Int32 inith = 0);
	C4DGadget* AddEditSlider        (Int32 id, Int32 flags, Int32 initw = 80, Int32 inith = 0);
	C4DGadget* AddSlider            (Int32 id, Int32 flags, Int32 initw = 90, Int32 inith = 0);
	C4DGadget* AddColorField        (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Int32 colorflags = 0/*DR_COLORFIELD_ICC_xxxx*/);
	C4DGadget* AddColorChooser      (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Int32 layoutflags = 0);
	C4DGadget* AddRadioButton				(Int32 id, Int32 flags, Int32 initw, Int32 inith, const String& name);
	C4DGadget* AddRadioText					(Int32 id, Int32 flags, Int32 initw, Int32 inith, const String& name);
	C4DGadget* AddEditShortcut      (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Int32 shortcutflags = 0);

	C4DGadget* AddSeparatorH        (Int32 initw, Int32 flags = BFH_FIT);
	C4DGadget* AddSeparatorV        (Int32 inith, Int32 flags = BFV_FIT);

	Bool AddRadioGroup							(Int32 id, Int32 flags, Int32 columns = 1, Int32 rows = 0);
	C4DGadget* AddComboBox          (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Bool specialalign = false);
	C4DGadget* AddComboButton				(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Bool specialalign = false);
	C4DGadget* AddPopupButton				(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0);
	Bool AddListView								(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0);

	Bool AddChild             (const GadgetPtr& id, Int32 subid, const String& child);
	Bool FreeChildren         (const GadgetPtr& id);
	Bool SetPopup							(const GadgetPtr& id, const BaseContainer& bc);
	Bool AddChildren					(const GadgetPtr& id, const BaseContainer& bc);

	C4DGadget* AddUserArea          (Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0);
	Bool AttachUserArea							(GeUserArea& ua, const GadgetPtr& id, USERAREAFLAGS userareaflags = USERAREA_COREMESSAGE);

	Bool AddSubDialog					(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0);
	Bool AttachSubDialog      (SubDialog* userdlg, Int32 id);

	Bool AddDlgGroup          (Int32 type);

	Bool GroupBeginInMenuLine	();
	Bool TabGroupBegin        (Int32 id, Int32 flags, Int32 tabtype = TAB_TABS);
	Bool GroupBegin           (Int32 id, Int32 flags, Int32 cols, Int32 rows, const String& title, Int32 groupflags, Int32 initw = 0, Int32 inith = 0);
	Bool GroupEnd             ();
	Bool GroupSpace           (Int32 spacex, Int32 spacey);
	Bool GroupBorder          (UInt32 borderstyle);
	Bool GroupBorderNoTitle		(UInt32 borderstyle);
	Bool GroupBorderSpace     (Int32 left, Int32 top, Int32 right, Int32 bottom);
	Bool GroupWeightsSave			(const GadgetPtr& id, BaseContainer& weights);
	Bool GroupWeightsLoad			(const GadgetPtr& id, const BaseContainer& weights);
	// flags for GroupWeights
	#define GROUPWEIGHTS_PERCENT_W_CNT 2000
	#define GROUPWEIGHTS_PERCENT_W_VAL (GROUPWEIGHTS_PERCENT_W_CNT + 1)
	#define GROUPWEIGHTS_PERCENT_H_CNT 3000
	#define GROUPWEIGHTS_PERCENT_H_VAL (GROUPWEIGHTS_PERCENT_H_CNT + 1)

	Bool GetItemDim           (const GadgetPtr& id, Int32* x, Int32* y, Int32* w, Int32* h);
	Bool GetDragPosition      (const BaseContainer& msg, Int32* x, Int32* y);
	Bool GetDragObject        (const BaseContainer& msg, Int32* type, void** object);
	Bool SetDragDestination   (Int32 cursor, Int32 gadgetid = 0);

	Bool GetVisibleArea       (Int32 scrollgroupid, Int32* x1, Int32* y1, Int32* x2, Int32* y2);
	Bool SetVisibleArea       (Int32 scrollgroupid, Int32 x1, Int32 y1, Int32 x2, Int32 y2);
	Bool ScrollGroupBegin     (Int32 id, Int32 flags, Int32 scrollflags, Int32 initw = 0, Int32 inith = 0);

	Bool LayoutChanged        (const GadgetPtr& id);
	Bool LayoutChangedNoRedraw(const GadgetPtr& id);
	Bool Activate             (const GadgetPtr& id);

	Bool LayoutFlushGroup     (const GadgetPtr& id);
	Bool RemoveElement				(const GadgetPtr& id);
	Bool HideElement					(const GadgetPtr& id, Bool hide);

	Bool RestoreLayout				(Int32 pluginid, Int32 subid, void* secret);

	Bool MenuFlushAll         ();														// call to create a complete new menu
	Bool MenuSubBegin         (const String& string);						// create a new menugroup
	Bool MenuSubEnd           ();														// close a menugroup
	Bool MenuAddCommand       (Int32 cmdid);										// add a command to the menugroup
	Bool MenuAddString        (Int32 id, const String& string);	// add a string to the menugroup
	Bool MenuAddSeparator     ();														// add a separator
	Bool MenuFinished         ();														// call when finished the menulayout
	Bool MenuInitString       (Int32 id, Bool enabled, Bool checked);

	Bool CheckClose						();

	void* FindCustomGui				(Int32 id, Int32 pluginid);
	void* AddCustomGui				(Int32 id, Int32 pluginid, const String& name, Int32 flags, Int32 minw, Int32 minh, const BaseContainer& customdata);
	Bool ReleaseLink();

	Bool MenuSetResource      (Int32 id);
	#ifdef __API_INTERN__
	Bool OpenPopUpMenu				(Int32 menuid, Int32 localx, Int32 localy, Int32 watchhotkey);
	#endif

	Bool CheckDropArea        (const GadgetPtr& id, const BaseContainer& msg, Bool horiz, Bool vert);
	Bool CheckCoreMessage			(const BaseContainer& msg, Int32* ownlastcoremsg = nullptr);	// speedup for CoreMessages, return true if new, false if it's a message of the same age

	static void HandleHelpString(const BaseContainer& msg, BaseContainer& result, const String& sym);

	// for private use only!!!
	void* GetWindowHandle			();
	// for private use only!!!

	//multiline text gadget
	Bool SetMultiLineMode(const GadgetPtr& id, SCRIPTMODE mode);
	Bool SetMultiLineLock(const GadgetPtr& id, Bool lock);
+/


	void * FindCustomGui(Int32 id, Int32 pluginid)
	{
		return C4DOS.Cd.FindCustomGui(Get(), id);
	}

	void * AddCustomGui(Int32 id, Int32 pluginid, ref const String  name, Int32 flags, Int32 minw, Int32 minh, ref const BaseContainer  t_customdata)
	{
		BaseContainer customdata = cast(BaseContainer)t_customdata;
		customdata.SetInt32(DROLDWIN_SDK, pluginid);
		void * r = nullptr;
		C4DOS.Cd.AddGadget(Get(), DIALOG_SDK, id, &name, flags, minw, minh, 0, &customdata, &r);
		return r;
	}

	Bool ReleaseLink()
	{
		return C4DOS.Cd.ReleaseLink(Get());
	}


	Bool SetPopup(ref const GadgetPtr  id, ref const BaseContainer bc) {
		if (!cd) return false;
		return C4DOS.Cd.SetPopup(cd, id.Id(), cast(BaseContainer*)&bc, cast(void*)id.Ptr());
	}
static if(API_VERSION >= 15000) { //R15 only
	Float GetPixelRatio() const	{
		if (!cd) return 1.0;
		return C4DOS.Cu.GetPixelRatio(cast(const CBaseFrame*)cd);
	}
}
	Bool Local2Global(Int32* x, Int32* y)
	{
		if (!cd)
			return false;
		return C4DOS.Cu.Local2Global(cast(CBaseFrame*)cd, x, y);
	}

	Bool Global2Local(Int32* x, Int32* y)
	{
		if (!cd)
			return false;
		return C4DOS.Cu.Global2Local(cast(CBaseFrame*)cd, x, y);
	}

	Bool Screen2Local(Int32* x, Int32* y)
	{
		if (!cd)
			return false;
		return C4DOS.Cu.Screen2Local(cast(CBaseFrame*)cd, x, y);
	}

	Bool Local2Screen(Int32* x, Int32* y)
	{
		if (!cd)
			return false;
		return C4DOS.Cu.Local2Screen(cast(CBaseFrame*)cd, x, y);
	}

	Bool SetBool(/*ref const*/in GadgetPtr  id, Bool value, Int32 tristate=0)	{
		return SetInt32(id, value, 0, !tristate ? 1 : 2, 0, tristate);
	}
	Bool SetInt32(/*ref const*/in GadgetPtr id, Int32 value, 
				  Int32 min = LIMIT!Int32.MIN, Int32 max = LIMIT!Int32.MAX, Int32 step = 1, Int32 tristate = 0, Int32 min2 = LIMIT!Int32.MIN, Int32 max2 = LIMIT!Int32.MAX)
	{
		BaseContainer msg = BaseContainer(CM_TYPE_INT);

		msg.SetInt32(CM_VALUE_VAL, value);
		msg.SetInt32(CM_VALUE_FORMAT, FORMAT_INT);
		msg.SetInt32(CM_VALUE_MIN, min);
		msg.SetInt32(CM_VALUE_MAX, max);
		msg.SetInt32(CM_VALUE_STEP, step);
		msg.SetInt32(CM_VALUE_TRISTATE, tristate);
		if (min2 != LIMIT!Int32.MIN || max2 != LIMIT!Int32.MAX) {
			msg.SetInt32(CM_VALUE_MIN2, min2);
			msg.SetInt32(CM_VALUE_MAX2, max2);
		}

		return SendMessage(id, msg).GetInt32();
	}

	Bool SetFloat(/*ref const*/in GadgetPtr  id, Float value, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 format = FORMAT_FLOAT, Float min2 = 0.0, Float max2 = 0.0, Bool quadscale = false, Int32 tristate = 0)
	{
		BaseContainer msg = BaseContainer(CM_TYPE_FLOAT);

		msg.SetFloat(CM_VALUE_VAL, value);
		msg.SetInt32(CM_VALUE_FORMAT, format);
		msg.SetFloat(CM_VALUE_MIN, min);
		msg.SetFloat(CM_VALUE_MAX, max);
		msg.SetFloat(CM_VALUE_STEP, step);
		msg.SetInt32(CM_VALUE_TRISTATE, tristate);

		if (min2 != 0.0 || max2 != 0.0)
		{
			msg.SetFloat(CM_VALUE_MIN2, min2);
			msg.SetFloat(CM_VALUE_MAX2, max2);
		}
		msg.SetInt32(CM_VALUE_QUADSCALE, quadscale);

		return SendMessage(id, msg).GetInt32();
	}

	Bool SetMultiLinePos(ref const GadgetPtr  id, Int32 line, Int32 pos)
	{
		BaseContainer msg = BaseContainer(BFM_SPECIALSETRANGE);
		msg.SetData(1, GeData(line));
		msg.SetData(2, GeData(pos));
		return SendMessage(id, msg).GetInt32();
	}

	Bool SetString()(auto ref const GadgetPtr  id,auto ref const String  text, Int32 tristate = 0, Int32 flags = 0)
	{
		BaseContainer msg = BaseContainer(BFM_TITLECHNG);
		msg.SetString(BFM_TITLECHNG, text);
		msg.SetInt32(CM_VALUE_TRISTATE, tristate);
		msg.SetInt32(CM_VALUE_VAL, flags);
		return SendMessage(id, msg).GetInt32();
	}

	Bool SetFilename()(auto ref const GadgetPtr  id,auto ref const Filename  fn, Int32 tristate = 0)
	{
		return SetString(id, fn.GetString(), tristate);
	}

	Bool SetMeter(ref const GadgetPtr  id, Float value, Float min, Float max, Float step, Int32 tristate = 0)
	{
		return SetFloat(id, value, min, max, step, FORMAT_METER, 0.0, 0.0, false, tristate);
	}

	Bool SetDegree(ref const GadgetPtr  id, Float radians_value, Float min = GUI_MINRANGE, Float max = GUI_MAXRANGE, Float step = 1.0, Int32 tristate = 0)
	{
		return SetFloat(id, radians_value, min == MINVALUE_FLOAT ? min : Rad(min), max == MAXVALUE_FLOAT ? max : Rad(max), Rad(step), FORMAT_DEGREE, 0.0, 0.0, false, tristate);
	}

	Bool SetPercent(/*ref const*/in GadgetPtr  id, Float value, Float min = 0.0, Float max = 100.0, Float step = 1.0, Int32 tristate = 0)
	{
		return SetFloat(id, value, min / cast(Float) 100.0, max / cast(Float) 100.0, step / cast(Float) 100.0, FORMAT_PERCENT, 0.0, 0.0, false, tristate);
	}

	Bool SetColorField()(auto ref const GadgetPtr  id,auto ref const Vector  color, Float brightness, Float maxbrightness, Int32 flags) {
		if (!cd) return false;
		return C4DOS.Cd.SetColorField(cd, id.Id(), color, brightness, maxbrightness, flags, id.Ptr());
	}


	Bool GetBool(ref const GadgetPtr id, ref Bool  value) const {
		if (!cd) return false;
		Int32 val;
		Bool	ok = C4DOS.Cd.GetInt32(cast(CDialog*)cd, id.Id(), val, id.Ptr());
		value = val != 0;
		return ok;
	}

	Bool GetInt32(ref const GadgetPtr  id, ref Int32  value) const {
		if (!cd) return false;
		return C4DOS.Cd.GetInt32(cast(CDialog*)cd, id.Id(), value, id.Ptr());
	}

	Bool GetFloat(ref const GadgetPtr  id, ref Float  value) const {
		if (!cd) return false;
		return C4DOS.Cd.GetFloat(cast(CDialog*)cd, id.Id(), value, id.Ptr());
	}

	Bool GetVector(ref const GadgetPtr  id_x, ref const GadgetPtr  id_y, ref const GadgetPtr  id_z, ref Vector  value) const
	{
		if (!GetFloat(id_x, value.x))
			return false;
		if (!GetFloat(id_y, value.y))
			return false;
		if (!GetFloat(id_z, value.z))
			return false;
		return true;
	}

	Bool GetString(ref const GadgetPtr  id, ref String  text) const {
		if (!cd)	return false;
		String* str = nullptr;
		Bool		res = C4DOS.Cd.GetString(cast(CDialog*)cd, id.Id(), str, id.Ptr());
		if (res && str)	{
			text = *str;
			gDelete(str); //DeleteObj(str);
		}
		return res;
	}

	Bool GetFilename(ref const GadgetPtr  id, ref Filename  fn) const
	{
		String str;
		Bool	 res = GetString(id, str);
		if (!res)
			return false;
		fn.SetString(str);
		return res;
	}

	Bool GetColorField(ref const GadgetPtr  id, ref Vector  color, ref Float  brightness) const
	{
		if (!cd)
			return false;
		return C4DOS.Cd.GetColorField(cast(CDialog*)cd, id.Id(), color, brightness, id.Ptr());
	}

	Bool GetBool(ref const GadgetPtr  id, BaseContainer* bc, Int32 bcid) const
	{
		Bool b	= false;
		Bool ok = GetBool(id, b);
		bc.SetBool(bcid, b);
		return ok;
	}

	Bool GetInt32(ref const GadgetPtr  id, BaseContainer* bc, Int32 bcid) const
	{
		Int32 b;
		Bool	ok = GetInt32(id, b);
		bc.SetInt32(bcid, b);
		return ok;
	}

	Bool GetFloat(ref const GadgetPtr  id, BaseContainer* bc, Int32 bcid) const
	{
		Float b;
		Bool	ok = GetFloat(id, b);
		bc.SetFloat(bcid, b);
		return ok;
	}

	Bool GetVector(ref const GadgetPtr  id_x, ref const GadgetPtr  id_y, ref const GadgetPtr  id_z, BaseContainer* bc, Int32 bcid) const
	{
		Vector v;
		if (!GetFloat(id_x, v.x))
			return false;
		if (!GetFloat(id_y, v.y))
			return false;
		if (!GetFloat(id_z, v.z))
			return false;
		bc.SetVector(bcid, v);
		return true;
	}

	Bool GetString(ref const GadgetPtr  id, BaseContainer* bc, Int32 bcid) const
	{
		String b;
		Bool	 ok = GetString(id, b);
		bc.SetString(bcid, b);
		return ok;
	}

	Bool GetFilename(ref const GadgetPtr  id, BaseContainer* bc, Int32 bcid) const
	{
		Filename b;
		Bool		 ok = GetFilename(id, b);
		bc.SetFilename(bcid, b);
		return ok;
	}

	Bool GetColorField(ref const GadgetPtr  id, BaseContainer* bc, Int32 bc_colid, Int32 bc_brightnessid) const
	{
		Vector c;
		Float	 b;
		Bool	 ok = GetColorField(id, c, b);
		if (bc_colid != NOTOK)
			bc.SetVector(bc_colid, c);
		if (bc_brightnessid != NOTOK)
			bc.SetFloat(bc_brightnessid, b);
		return ok;
	}

	Bool SetBool(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid)	{
		return SetBool(id, bc.GetBool(bcid));
	}

	Bool SetInt32(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Int32 min, Int32 max, Int32 step, Int32 min2, Int32 max2)
	{
		return SetInt32(id, bc.GetInt32(bcid), min, max, step, 0, min2, max2);
	}

	Bool SetFloat(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Float min, Float max, Float step, Int32 format, Float min2, Float max2, Bool quadscale)
	{
		return SetFloat(id, bc.GetFloat(bcid), min, max, step, format, min2, max2, quadscale);
	}

	Bool SetMeter(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Float min, Float max, Float step)
	{
		return SetMeter(id, bc.GetFloat(bcid), min, max, step);
	}

	Bool SetDegree(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Float min, Float max, Float step)
	{
		return SetDegree(id, bc.GetFloat(bcid), min, max, step);
	}

	Bool SetPercent(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Float min, Float max, Float step)
	{
		return SetPercent(id, bc.GetFloat(bcid), min, max, step);
	}

	Bool SetString(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid, Int32 flags)
	{
		return SetString(id, bc.GetString(bcid), 0, flags);
	}

	Bool SetFilename(ref const GadgetPtr  id, const BaseContainer* bc, Int32 bcid)
	{
		return SetFilename(id, bc.GetFilename(bcid));
	}

	Bool SetColorField()(auto ref const GadgetPtr  id, const BaseContainer* bc, Int32 bc_colid, Int32 bc_brightnessid, Float maxbrightness, Int32 flags)
	{
		Float bright = 1.0;
		if (bc_brightnessid != -1)
			bright = bc.GetFloat(bc_brightnessid);
		return SetColorField(id, bc.GetVector(bc_colid), bright, maxbrightness, flags);
	}
/+
	Bool SetTime(ref const GadgetPtr  id, const BaseDocument* doc, ref const BaseTime  value, ref const BaseTime  const BaseTime& min = BaseTime(-MAXTIME, 1), const BaseTime& max = BaseTime(MAXTIME, 1), Int32 stepframes = 1, Int32 tristate = 0)
	{
		if (!doc)
			doc = C4DOS.Ge.GetActiveDocument();
		if (!doc)
			return false;

		Int32 fps = doc.GetFps();
		BaseContainer msg = BaseContainer(CM_TYPE_FLOAT);

		msg.SetFloat(CM_VALUE_VAL, Floor(value.GetNumerator() * fps) / Floor(value.GetDenominator()));
		msg.SetInt32(CM_VALUE_FORMAT, FORMAT_FRAMES);
		msg.SetFloat(CM_VALUE_MIN, Floor(min.GetNumerator() * fps) / Floor(min.GetDenominator()));
		msg.SetFloat(CM_VALUE_MAX, Floor(max.GetNumerator() * fps) / Floor(max.GetDenominator()));
		msg.SetFloat(CM_VALUE_STEP, 1.0);
		msg.SetInt32(CM_VALUE_QUADSCALE, false);
		msg.SetInt32(CM_VALUE_FPS, fps);
		msg.SetInt32(CM_VALUE_TRISTATE, tristate);
		/*
		if (min2.Get() != 0.0 || max2 != 0.0)
		{
		msg.SetFloat(CM_VALUE_MIN2, min2);
		msg.SetFloat(CM_VALUE_MAX2, max2);
		}
		*/
		return SendMessage(id, msg).GetInt32();
	}

	Bool GetTime(ref const GadgetPtr  id, const BaseDocument* doc, ref BaseTime  time) const
	{
		if (!doc)
			doc = C4DOS.Ge.GetActiveDocument();
		if (!doc)
			return false;

		Int32 fps = doc.GetFps();

		Float b;
		Bool	ok = GetFloat(id, b);
		time = BaseTime(b * cast(Float) 1000.0, fps * cast(Float) 1000.0);
		return ok;
	}

	Bool SetTime(ref const GadgetPtr  id, const BaseDocument* doc, const BaseContainer* bc, Int32 bcid, ref const BaseTime  min, ref const BaseTime  max, Int32 stepframes)
	{
		return SetTime(id, doc, bc.GetTime(bcid), min, max, stepframes);
	}

	Bool GetTime(ref const GadgetPtr  id, const BaseDocument* doc, BaseContainer* bc, Int32 bcid) const
	{
		BaseTime time;
		Bool		 ok = GetTime(id, doc, time);
		bc.SetTime(bcid, time);
		return ok;
	}
+/
	Bool CheckTristateChange(ref const GadgetPtr  id)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_GETTRISTATE, id.Id(), nullptr, 0, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	C4DGadget* AddCheckbox()(Int32 id, Int32 flags, Int32 initw, Int32 inith,auto ref const String  name)	{
		if (!cd) return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_CHECKBOX, id, cast(String*)&name, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	Bool MenuSetResource(Int32 id)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_MENURESOURCE, id, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	C4DGadget* AddSeparatorH(Int32 initw, Int32 flags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_SEPARATOR, 0, nullptr, flags, initw, 0, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddSeparatorV(Int32 initw, Int32 flags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_SEPARATOR, 0, nullptr, flags, 0, initw, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	Bool AddSubDialog(Int32 id, Int32 flags, Int32 initw, Int32 inith)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_SUBDIALOG, id, nullptr, flags, initw, inith, 0, nullptr, nullptr);
	}

	C4DGadget* AddRadioButton(Int32 id, Int32 flags, Int32 initw, Int32 inith, ref const String  name)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_RADIOBUTTON, id, cast(String*)&name, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddRadioText(Int32 id, Int32 flags, Int32 initw, Int32 inith, ref const String  name)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_RADIOTEXT, id, cast(String*)&name, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddButton(Int32 id, Int32 flags, Int32 initw, Int32 inith, ref const String  name)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_BUTTON, id, cast(String*)&name, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddStaticText(Int32 id, Int32 flags, Int32 initw, Int32 inith, in String  name, Int32 borderstyle)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_STATICTEXT, id, cast(String*)&name, flags, initw, inith, borderstyle, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	Bool AddListView(Int32 id, Int32 flags, Int32 initw, Int32 inith)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_LISTVIEW, id, nullptr, flags, initw, inith, 0, nullptr, nullptr);
	}

	C4DGadget* AddArrowButton(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 arrowtype)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_ARROWBUTTON, id, nullptr, flags, initw, inith, arrowtype, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddEditShortcut(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 shortcutflags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_EDITSHORTCUT, id, nullptr, flags, initw, inith, shortcutflags, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddEditText(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 editflags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_EDITTEXT, id, nullptr, flags, initw, inith, editflags, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddMultiLineEditText(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 style)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_MULTILINEEDITTEXT, id, nullptr, flags, initw, inith, style, nullptr, &r);
		return cast(C4DGadget*)r;
	}


	C4DGadget* AddEditNumber(Int32 id, Int32 flags, Int32 initw, Int32 inith)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_EDITNUMBER, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddEditNumberArrows(Int32 id, Int32 flags, Int32 initw = 70, Int32 inith = 0)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_EDITNUMBERUD, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddEditSlider(Int32 id, Int32 flags, Int32 initw = 80, Int32 inith = 0)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_EDITSLIDER, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddSlider(Int32 id, Int32 flags, Int32 initw, Int32 inith)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_SLIDER, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddColorField(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 colorflags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_COLORFIELD, id, nullptr, flags, initw, inith, colorflags, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddColorChooser(Int32 id, Int32 flags, Int32 initw, Int32 inith, Int32 layoutflags)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_COLORCHOOSER, id, nullptr, flags, initw, inith, layoutflags, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	Bool AddRadioGroup(Int32 id, Int32 flags, Int32 columns, Int32 rows)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_RADIOGROUP, id, nullptr, flags, columns, rows, 0, nullptr, nullptr);
	}

	C4DGadget* AddComboBox(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0, Bool specialalign = false) {
		if (!cd) return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_COMBOBOX, id, nullptr, flags, initw, inith, specialalign, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddComboButton(Int32 id, Int32 flags, Int32 initw, Int32 inith, Bool specialalign)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_COMBOBUTTON, id, nullptr, flags, initw, inith, specialalign, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	C4DGadget* AddPopupButton(Int32 id, Int32 flags, Int32 initw, Int32 inith)
	{
		if (!cd)
			return nullptr;
		void * r = nullptr;
		C4DOS.Cd.AddGadget(cd, DIALOG_POPUPBUTTON, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}

	Bool AddChild()(in GadgetPtr  id, Int32 subid,in String  child)	{
		if (!cd) return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_CHILD, id.Id(), cast(String*)&child, subid, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	Bool AddChild()(Int32 id, Int32 subid,in String  child)	{ //test
		if (!cd) return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_CHILD, id, cast(String*)&child, subid, 0, 0, 0, nullptr, nullptr);
	}

	/*Bool AddChild(ref const GadgetPtr  id, Int32 subid, ref const String  child)	{
		if (!cd) return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_CHILD, id.Id(), cast(String*)&child, subid, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}
	Bool AddChild(in GadgetPtr id, Int32 subid, in String child)	{
		if (!cd) return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_CHILD, id.Id(), cast(String*)&child, subid, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}*/

/+
	Bool AddChildren(ref const GadgetPtr  id, ref const BaseContainer  bc)
	{
		BrowseContainer br = BrowseContainer(&bc);
		Int32		sid;
		GeData* dat;
		while (br.GetNext(&sid, &dat))
		{
			if (!dat)
				continue;
			if (!AddChild(id, sid, dat.GetString()))
				return false;
		}
		return true;
	}
+/
	Bool FreeChildren(ref const GadgetPtr  id) {
		if (!cd)	return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_FREECHILDREN, id.Id(), nullptr, 0, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	C4DGadget* AddUserArea(Int32 id, Int32 flags, Int32 initw = 0, Int32 inith = 0)
	{
		if (!cd) return null;
		void* r = null;
		C4DOS.Cd.AddGadget(cd, DIALOG_USERAREA, id, nullptr, flags, initw, inith, 0, nullptr, &r);
		return cast(C4DGadget*)r;
	}


	Bool GroupSpace(Int32 spacex, Int32 spacey)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.GroupSpace(cd, spacex, spacey);
	}

	Bool GroupBorder(UInt32 borderstyle)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.GroupBorder(cd, borderstyle | BORDER_WITH_TITLE);
	}

	Bool GroupBorderNoTitle(UInt32 borderstyle)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.GroupBorder(cd, borderstyle);
	}

	Bool GroupBorderSpace(Int32 left, Int32 top, Int32 right, Int32 bottom)
	{
		if (!cd)
			return false;
		return C4DOS.Cd.GroupBorderSize(cd, left, top, right, bottom);
	}

	Bool AttachUserArea(GeUserArea  ua,in GadgetPtr id, USERAREAFLAGS userareaflags = USERAREA_COREMESSAGE) //TODO 
	{
		C4DOS.Cu.Free(ua.cu);
		ua.cu	 = null;
		ua.dlg   = this;
		ua.cu	 = C4DOS.Cd.AttachUserArea(cd, id.Id(), /*cast(void*)*/ua, userareaflags, id.Ptr());
		//printf(" AttachUserArea ua.cu=%p  %p \n",ua.cu, id.Ptr());
		return ua.cu != null;
	}

	Bool AddDlgGroup(Int32 type){
		if (!cd)
			return false;
		return C4DOS.Cd.AddGadget(cd, DIALOG_DLGGROUP, 0, nullptr, type, 0, 0, 0, nullptr, nullptr);
	}

	Bool CheckClose(){
		return C4DOS.Cd.AddGadget(Get(), DIALOG_CHECKCLOSE, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}
/+
	Bool AttachSubDialog(SubDialog* userdlg, Int32 id)
	{
		if (!userdlg)
			return false;

		userdlg.createlayout = false;

		return C4DOS.Cd.AttachSubDialog(Get(), id, userdlg.Get());
	}
+/

/+
	Bool LoadDialogResource(Int32 id, GeResource* lr, Int32 flags)
	{
		static if(!__API_INTERN__) {
		if (!lr)
			lr = &resource;
		return C4DOS.Cd.LoadDialogResource(cd, id, lr.Get(), flags);
		} else {
		return C4DOS.Cd.LoadDialogResource(cd, id, nullptr, flags);
		}
	}
+/
	Bool SetVisibleArea(Int32 scrollgroupid, Int32 x1, Int32 y1, Int32 x2, Int32 y2)
	{
		return C4DOS.Cd.SetVisibleArea(cd, scrollgroupid, x1, y1, x2, y2);
	}

	Bool GetVisibleArea(Int32 scrollgroupid, Int32* x1, Int32* y1, Int32* x2, Int32* y2)
	{
		return C4DOS.Cd.GetVisibleArea(cd, scrollgroupid, x1, y1, x2, y2);
	}

	Bool GetItemDim(ref const GadgetPtr  id, Int32* x, Int32* y, Int32* w, Int32* h){
		return C4DOS.Cd.GetItemDim(cd, id.Id(), x, y, w, h, id.Ptr());
	}
	Bool GetItemDim(int id, Int32* x, Int32* y, Int32* w, Int32* h){
		return C4DOS.Cd.GetItemDim(cd, id, x, y, w, h, null);
	}

	Bool LayoutChanged()(auto ref const GadgetPtr  id){
		return C4DOS.Cd.AddGadget(cd, DIALOG_LAYOUTCHANGED, id.Id(), nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool LayoutChangedNoRedraw(ref const GadgetPtr  id)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_LAYOUTCHANGED, id.Id(), nullptr, true, 0, 0, 0, nullptr, nullptr);
	}

	Bool Activate(ref const GadgetPtr  id)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ACTIVATE, id.Id(), nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool GroupWeightsSave(ref const GadgetPtr  id, ref BaseContainer  weights)
	{
		BaseContainer storehere = NOTOK;
		Bool ret = C4DOS.Cd.AddGadget(cd, DIALOG_SAVEWEIGHTS, id.Id(), nullptr, 0, 0, 0, 0, &storehere, cast(void **)id.Ptr());
		if (ret)
			weights = storehere;
		return ret;
	}

	Bool GroupWeightsLoad(ref const GadgetPtr  id, ref const BaseContainer  weights)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_LOADWEIGHTS, id.Id(), nullptr, 0, 0, 0, 0, &weights, cast(void **)id.Ptr());
	}

	Bool LayoutFlushGroup()(auto ref const GadgetPtr  id)	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_FLUSHGROUP, id.Id(), nullptr, 0, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	Bool RemoveElement(ref const GadgetPtr  id)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_REMOVEGADGET, id.Id(), nullptr, 0, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	Bool HideElement(ref const GadgetPtr  id, Bool hide)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_HIDEELEMENT, id.Id(), nullptr, hide, 0, 0, 0, nullptr, cast(void **)id.Ptr());
	}

	Bool ScrollGroupBegin(Int32 id, Int32 flags, Int32 scrollflags, Int32 initw = 0, Int32 inith = 0)	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_SCROLLGROUP, id, nullptr, flags, initw, inith, scrollflags, nullptr, nullptr);
	}


	Bool MenuSubBegin()(auto ref const String string)	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ADDSUBMENU, 0, cast(String*)&string, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool MenuSubEnd()
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ENDSUBMENU, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool MenuAddCommand(Int32 cmdid)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ADDMENUCMD, cmdid, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool MenuAddSeparator()
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ADDMENUSEP, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	//Bool MenuAddString()(Int32 id,auto ref const String string)	{
	//	return C4DOS.Cd.AddGadget(cd, DIALOG_ADDMENUSTR, id, cast(String*)&string, 0, 0, 0, 0, nullptr, nullptr);
	//}

	Bool MenuAddString(Int32 id,in String string)	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_ADDMENUSTR, id, cast(String*)&string, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool MenuInitString(Int32 id, Bool enabled, Bool checked)
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_INITMENUSTR, id, nullptr, enabled, checked, 0, 0, nullptr, nullptr);
	}

	Bool MenuFlushAll()
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_FLUSHMENU, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool MenuFinished()
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_SETMENU, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool GetDragPosition(ref const BaseContainer  msg, Int32* x, Int32* y)
	{
		if (x)
			*x = msg.GetInt32(BFM_DRAG_SCREENX);
		if (y)
			*y = msg.GetInt32(BFM_DRAG_SCREENY);
		return C4DOS.Cd.Screen2Local(cd, x, y);
	}

	Bool GetDragObject(ref const BaseContainer  msg, Int32* type, void ** object)
	{
		return C4DOS.Cd.GetDragObject(cd, cast(BaseContainer*)&msg, type, object);
	}


	Bool CheckValueRanges()
	{
		return C4DOS.Cd.AddGadget(cd, DIALOG_CHECKNUMBERS, 0, nullptr, 0, 0, 0, 0, nullptr, nullptr);
	}

	Bool CheckDropArea(ref const GadgetPtr  id, ref const BaseContainer  msg, Bool horiz, Bool vert){
		Int32 x, y, w, h, dx, dy;
		GetDragPosition(msg, &dx, &dy);
		GetItemDim(id, &x, &y, &w, &h);
		if (horiz && vert)
			return dx > x && dx < x + w && dy > y && dy < y + h;
		else if (vert)
			return dy > y && dy < y + h;
		return dx > x && dx < x + w;
	}

	Bool CheckCoreMessage(ref const BaseContainer msg, Int32* ownlastcoremsg = null){
		Int32* storage = ownlastcoremsg;
		if (!storage)
			storage = &t_lastcoremsg;

		Int32 coremsg = msg.GetInt32(BFM_CORE_UNIQUEID);
		if (!coremsg)
			return true;
		if (coremsg == *storage)
			return false;
		if (coremsg == msg.GetInt32(BFM_CORE_ID) && (cast(UInt)msg.GetVoid(BFM_CORE_PAR1) & cast(UInt)EVENT_GLHACK))
			return false;
		*storage = coremsg;
		return true;
	}

	void HandleHelpString(/*ref const*/in BaseContainer  msg, ref BaseContainer  result, /*ref const*/in String  sym) {
		const BaseContainer* bc = msg.GetContainerInstance(BFM_GETCURSORINFO);
		if (bc && bc.GetDataPointer(RESULT_HELP1) != nullptr)
			return;
		result = msg.GetContainer(BFM_GETCURSORINFO);
		if (result.GetId() == -1 || result.GetId() == 0)
			result.SetId(BFM_GETCURSORINFO);
		result.SetString(RESULT_HELP1, sym);
	}

	// for private use only!!!
	void* GetWindowHandle()	{ return C4DOS.Cd.CBF_GetWindowHandle(cast(CBaseFrame*)cd);	}

	Bool SetMultiLineMode(ref const GadgetPtr  id, SCRIPTMODE mode){
		BaseContainer msg = BaseContainer(BFM_SPECIALMODE);
		msg.SetInt32(1, mode);
		return SendMessage(id, msg).GetInt32();
	}

	Bool SetMultiLineLock(ref const GadgetPtr  id, Bool lock) {
		BaseContainer msg = BaseContainer(lock ? BFM_SETSPECIALMULTI : BFM_SETSPECIALMULTID);
		msg.SetInt32(msg.GetId(), DR_MULTILINE_READONLY);
		return SendMessage(id, msg).GetInt32();
	}
};

// } //extern (C++) !!!
