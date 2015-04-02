/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////

module c4d_prepass;

public import re_meta; 
import c4d;

//mixin EnumUpScope!(STRINGENCODING);

/*enum BYTEORDER
{
	BYTEORDER_MOTOROLA	 = 1,
	BYTEORDER_INTEL		 = 2
} 
mixin EnumUpScope!(BYTEORDER);
//mixin ENUM_END_LIST!(BYTEORDER);*/

//#define C4D_FOUR_BYTE(x1, x2, x3, x4)			((x1 << 24) | (x2 << 16) | (x3 << 8) | x4)
auto C4D_FOUR_BYTE(ARG1, ARG2, ARG3, ARG4)(ARG1 x1, ARG2 x2, ARG3 x3, ARG4 x4) { return ((x1 << 24) | (x2 << 16) | (x3 << 8) | x4); }


//regex:    
//	'(\w*)'    
//	C4D_FOUR_BYTE("$1")
auto C4D_FOUR_BYTE(in string s){ return (( cast(char)s[0] << 24) | (cast(char)s[1] << 16) | (cast(char)s[2] << 8) | cast(char)s[3]); }

string FOUR_BYTE_TO_C4D(Int32 id){
	char[] str = "0000".dup; //bad ?
	str[3] = (id & 0xff);
	str[2] = (id >>  8) & 0xff;
	str[1] = (id >> 16) & 0xff;
	str[0] = (id >> 24) & 0xff;
	return str.idup; //bad ?
}


//pragma(msg,C4D_FOUR_BYTE('s','d','k','8'));
//pragma(msg,C4D_FOUR_BYTE("sdk8"));

static assert(C4D_FOUR_BYTE('s','d','k','8') == C4D_FOUR_BYTE("sdk8"));
static assert(C4D_FOUR_BYTE('b','I','N','I') == C4D_FOUR_BYTE("bINI"));


//todo >>>
//void ENUM_END_FLAGS!(T)(T en){ }
//void mixin ENUM_END_LIST!(T)(T en){  }

mixin template ENUM_END_FLAGS(en) {
	static assert(is(en == enum));
	mixin EnumUpScope!(__traits(identifier,en),__traits(allMembers, en));
}
mixin template ENUM_END_LIST(en) {
	static assert(is(en == enum));
	mixin EnumUpScope!(__traits(identifier,en),__traits(allMembers, en));
}
/*
enum _DONTCONSTRUCT
{
	DC
} mixin ENUM_END_FLAGS!(_DONTCONSTRUCT);

enum _EMPTYCONSTRUCT
{
	EC
} mixin ENUM_END_FLAGS!(_EMPTYCONSTRUCT);
*/
//todo >>>

//enum MACTYPE_CINEMA =		'C4DC';
//enum MACCREATOR_CINEMA =	'C4D1';
enum MACTYPE_CINEMA =		C4D_FOUR_BYTE('C','4','D','C');
enum MACCREATOR_CINEMA =	C4D_FOUR_BYTE('C','4','D','1');

version (X86_64) {
	enum __C4D_64BIT = 1;
}else version (X86){
	enum __C4D_64BIT = 0;
}

static if(__C4D_64BIT) {
enum MAX_IMAGE_RESOLUTION = 128000;	// if changed, also change MAXMIPANZ
} else {
enum MAX_IMAGE_RESOLUTION = 16000;
}

enum RENDERJOBLIST
{
	RENDERJOBLIST_INACTIVE = 1 << 1,
	RENDERJOBLIST_ACTIVE	 = 1 << 2,
	RENDERJOBLIST_LOAD		 = 1 << 3,
	RENDERJOBLIST_ALL			 = 14	// RENDERJOBLIST_INACTIVE | RENDERJOBLIST_ACTIVE | RENDERJOBLIST_LOAD
} mixin ENUM_END_FLAGS!(RENDERJOBLIST);

enum MESSAGERESULT
{
	MESSAGERESULT_OK = 1000,
	MESSAGERESULT_CONNECTIONERROR,
	MESSAGERESULT_UNHANDLED,
	MESSAGERESULT_MEMORYERROR
} mixin ENUM_END_LIST!(MESSAGERESULT);

enum MACHINELIST
{
	MACHINELIST_ONLINE	= 1 << 1,
	MACHINELIST_OFFLINE = 1 << 0,
	MACHINELIST_ALL			= 7,	// MACHINELIST_ONLINE | MACHINELIST_OFFLINE
} mixin ENUM_END_FLAGS!(MACHINELIST);

enum VERIFICATIONBIT
{
	VERIFICATIONBIT_0					 = 0,
	VERIFICATIONBIT_ONLINE		 = 1 << 0,
	VERIFICATIONBIT_VERIFIED	 = 1 << 1,
	VERIFICATIONBIT_VERIFIEDME = 1 << 2,
	VERIFICATIONBIT_SHARED		 = 1 << 3,
	VERIFICATIONBIT_VERIFYING	 = 1 << 4,

	// error bits - if you add an enum also add it
	// to netrender/source/common.cpp#GetErrorVerificationBits
	VERIFICATIONBIT_UNKNOWN							 = 1 << 5,
	VERIFICATIONBIT_FAILED							 = 1 << 6,
	VERIFICATIONBIT_SECURITYTOKENCHANGED = 1 << 7,
	VERIFICATIONBIT_WRONGBUILDID				 = 1 << 8,
	VERIFICATIONBIT_WRONGARCHITECTURE		 = 1 << 9,
	VERIFICATIONBIT_REMOTENOTREACHABLE	 = 1 << 10,
	VERIFICATIONBIT_THISNOTREACHABLE		 = 1 << 11,
	VERIFICATIONBIT_WRONGSECURITYTOKEN	 = 1 << 12,
	VERIFICATIONBIT_DEMONOTACTIVATED		 = 1 << 13,
	VERIFICATIONBIT_REMOVING						 = 1 << 14
} mixin ENUM_END_FLAGS!(VERIFICATIONBIT);

enum RENDERJOBCREATOR
{
	RENDERJOBCREATOR_BATCHRENDER = 1000,
	RENDERJOBCREATOR_PICTUREVIEWER,
	RENDERJOBCREATOR_USER,
	RENDERJOBCREATOR_OTHER
} mixin ENUM_END_LIST!(RENDERJOBCREATOR);

enum STATUSNETSTATE
{
	STATUSNETSTATE_NONE = 0,
	STATUSNETSTATE_DISABLE,
	STATUSNETSTATE_IDLE,
	STATUSNETSTATE_BUSY,
	STATUSNETSTATE_BUSY2
} mixin ENUM_END_FLAGS!(STATUSNETSTATE);

enum C4DUUID_SIZE = 16;	// size of the uuid object

// BaseBitmap::Save
enum FILTER_TIF =								1100;
enum FILTER_TGA =								1101;
enum FILTER_BMP =								1102;
enum FILTER_IFF =								1103;
enum FILTER_JPG =								1104;
enum FILTER_PICT =								1105;
enum FILTER_PSD =								1106;
enum FILTER_RLA =								1107;
enum FILTER_RPF =								1108;
enum FILTER_B3D =								1109;
enum FILTER_TIF_B3D =						1110;
enum FILTER_PSB =								1111;
enum FILTER_AVI =								1122;
enum FILTER_MOVIE =							1125;
enum FILTER_QTVRSAVER_PANORAMA =	1150;
enum FILTER_QTVRSAVER_OBJECT =		1151;
enum FILTER_HDR =								1001379;
enum FILTER_EXR_LOAD =						1016605;
enum FILTER_EXR =								1016606;
enum FILTER_PNG =								1023671;
enum FILTER_IES =								1024463;
enum FILTER_B3DNET =							1099;	// private
enum FILTER_DPX =								1023737;

enum AVISAVER_FCCTYPE =		10000;
enum AVISAVER_FCCHANDLER =	10001;
enum AVISAVER_LKEY =				10002;
enum AVISAVER_LDATARATE =	10003;
enum AVISAVER_LQ =					10004;

enum QTSAVER_COMPRESSOR =		 10010;
enum QTSAVER_QUALITY =				 10011;
enum QTSAVER_TEMPQUAL =			 10012;
enum QTSAVER_FRAMERATE =			 10013;
enum QTSAVER_KEYFRAMES =			 10014;
enum QTSAVER_PLANES =				 10015;
enum QTSAVER_DATARATE =			 10016;
enum QTSAVER_FRAMEDURATION =	 10017;
enum QTSAVER_MINQUALITY =		 10018;
enum QTSAVER_MINTEMPQUAL =		 10019;
enum QTSAVER_FIXEDFRAMERATE = 10020;

enum JPGSAVER_QUALITY = 10021;
enum IMAGESAVER_DPI =	 10022;
enum PNG_INTERLACED =	 11000;
enum RLA_OPTIONS =			 10024;
enum DPX_PLANAR =			 11000;

enum RLAFLAGS
{
	RLAFLAGS_0							 = 0,
	RLAFLAGS_Z							 = (1 << 0),
	RLAFLAGS_OBJECTBUFFER		 = (1 << 2),
	RLAFLAGS_UV							 = (1 << 3),
	RLAFLAGS_NORMAL					 = (1 << 4),
	RLAFLAGS_ORIGCOLOR			 = (1 << 5),
	RLAFLAGS_COVERAGE				 = (1 << 6),
	RLAFLAGS_OBJECTID				 = (1 << 8),
	RLAFLAGS_COLOR					 = (1 << 9),
	RLAFLAGS_TRANSPARENCY		 = (1 << 10),
	RLAFLAGS_SUBPIXEL_WEIGHT = (1 << 12),
	RLAFLAGS_SUBPIXEL_MASK	 = (1 << 13)
} mixin ENUM_END_FLAGS!(RLAFLAGS);

enum ASSETDATA_FLAG
{
	ASSETDATA_FLAG_0								= 0,
	ASSETDATA_FLAG_CURRENTFRAMEONLY	= (1 << 0),
	ASSETDATA_FLAG_TEXTURES					= (1 << 1),	// only return texture assets
	ASSETDATA_FLAG_NET							= (1 << 2)  // set if NET is collecting assets to distribute them to the clients
} mixin ENUM_END_FLAGS!(ASSETDATA_FLAG);

// savebits
enum SAVEBIT
{
	SAVEBIT_0									= 0,
	SAVEBIT_ALPHA							= (1 << 0),
	SAVEBIT_MULTILAYER				= (1 << 1),
	SAVEBIT_USESELECTEDLAYERS	= (1 << 2),
	SAVEBIT_16BITCHANNELS			= (1 << 3),
	SAVEBIT_GREYSCALE					= (1 << 4),
	SAVEBIT_INTERNALNET				= (1 << 5),	// private
	SAVEBIT_DONTMERGE					= (1 << 7),	// flag to avoid merging of layers in b3d files
	SAVEBIT_32BITCHANNELS			= (1 << 8),
	SAVEBIT_SAVERENDERRESULT	= (1 << 9),
	SAVEBIT_FIRSTALPHA_ONLY		= (1 << 10)	// private
} mixin ENUM_END_FLAGS!(SAVEBIT);

enum SCENEFILTER
{
	SCENEFILTER_0								 = 0,
	SCENEFILTER_OBJECTS					 = (1 << 0),
	SCENEFILTER_MATERIALS				 = (1 << 1),
	SCENEFILTER_DIALOGSALLOWED	 = (1 << 3),
	SCENEFILTER_PROGRESSALLOWED	 = (1 << 4),
	SCENEFILTER_MERGESCENE			 = (1 << 5),
	SCENEFILTER_NONEWMARKERS		 = (1 << 6),
	SCENEFILTER_SAVECACHES			 = (1 << 7),	// for melange export only
	SCENEFILTER_NOUNDO					 = (1 << 8),
	SCENEFILTER_SAVE_BINARYCACHE = (1 << 10),
	SCENEFILTER_IDENTIFY_ONLY		 = (1 << 11)
} mixin ENUM_END_FLAGS!(SCENEFILTER);

// GeOutString
enum GEMB
{
	GEMB_OK								= 0x0000,
	GEMB_OKCANCEL					= 0x0001,
	GEMB_ABORTRETRYIGNORE	= 0x0002,
	GEMB_YESNOCANCEL			= 0x0003,
	GEMB_YESNO						= 0x0004,
	GEMB_RETRYCANCEL			= 0x0005,
	GEMB_FORCEDIALOG			= 0x8000,
	GEMB_ICONSTOP					= 0x0010,
	GEMB_ICONQUESTION			= 0x0020,
	GEMB_ICONEXCLAMATION	= 0x0030,
	GEMB_ICONASTERISK			= 0x0040,
	GEMB_MULTILINE				= 0x0080
} mixin ENUM_END_FLAGS!(GEMB);

enum GEMB_R
{
	GEMB_R_UNDEFINED = 0,
	GEMB_R_OK				 = 1,
	GEMB_R_CANCEL		 = 2,
	GEMB_R_ABORT		 = 3,
	GEMB_R_RETRY		 = 4,
	GEMB_R_IGNORE		 = 5,
	GEMB_R_YES			 = 6,
	GEMB_R_NO				 = 7
} mixin ENUM_END_LIST!(GEMB_R);

enum MOUSEDRAGRESULT
{
	MOUSEDRAGRESULT_ESCAPE	 = 1,
	MOUSEDRAGRESULT_FINISHED = 2,
	MOUSEDRAGRESULT_CONTINUE = 3
} mixin ENUM_END_LIST!(MOUSEDRAGRESULT);

enum MOUSEDRAGFLAGS
{
	MOUSEDRAGFLAGS_0										 = 0,
	MOUSEDRAGFLAGS_DONTHIDEMOUSE				 = (1 << 0),	// mousepointer should be visible
	MOUSEDRAGFLAGS_NOMOVE								 = (1 << 1),	// mousedrag returns if no mousemove was done
	MOUSEDRAGFLAGS_EVERYPACKET					 = (1 << 2),	// receive every packet of the queue, otherwise only data of the last packet
	MOUSEDRAGFLAGS_COMPENSATEVIEWPORTORG = (1 << 3),	// compensates the viewport origin during drag
	MOUSEDRAGFLAGS_AIRBRUSH							 = (1 << 4)
} mixin ENUM_END_FLAGS!(MOUSEDRAGFLAGS);

enum INITRENDERRESULT
{
	INITRENDERRESULT_OK						= 0,
	INITRENDERRESULT_OUTOFMEMORY	= -100,
	INITRENDERRESULT_ASSETMISSING	= -101,
	INITRENDERRESULT_UNKNOWNERROR	= -102,
	INITRENDERRESULT_THREADEDLOCK	= -103
} mixin ENUM_END_LIST!(INITRENDERRESULT);

enum RENDERRESULT
{
	RENDERRESULT_OK									 = 0,
	RENDERRESULT_OUTOFMEMORY				 = 1,
	RENDERRESULT_ASSETMISSING				 = 2,
	RENDERRESULT_SAVINGFAILED				 = 5,
	RENDERRESULT_USERBREAK					 = 6,
	RENDERRESULT_GICACHEMISSING			 = 7,
	RENDERRESULT_NOMACHINE					 = 9,			// can only happen during team rendering

	RENDERRESULT_PROJECTNOTFOUND		 = 1000,	// can only be returned by the app during command line rendering
	RENDERRESULT_ERRORLOADINGPROJECT = 1001,	// can only be returned by the app during command line rendering
	RENDERRESULT_NOOUTPUTSPECIFIED	 = 1002		// can only be returned by the app during command line rendering
} mixin ENUM_END_LIST!(RENDERRESULT);

enum BITDEPTH_SHIFT = 4;

enum BITDEPTH_MAXMODES =	3;

enum BITDEPTH_UCHAR = 0;
enum BITDEPTH_UWORD = 1;
enum BITDEPTH_FLOAT = 2;

// color mode for bitmaps
// the most common values are COLORMODE_RGB for 24-bit RGB values and COLORMODE_GRAY for 8-bit greyscale values
enum COLORMODE
{
	COLORMODE_ILLEGAL	= 0,

	COLORMODE_ALPHA		= 1,	// only alpha channel
	COLORMODE_GRAY		= 2,
	COLORMODE_AGRAY		= 3,
	COLORMODE_RGB			= 4,
	COLORMODE_ARGB		= 5,
	COLORMODE_CMYK		= 6,
	COLORMODE_ACMYK		= 7,
	COLORMODE_MASK		= 8,	// gray map as mask
	COLORMODE_AMASK		= 9,	// gray map as mask

	// 16 bit modes
	COLORMODE_ILLEGALw = (BITDEPTH_UWORD << BITDEPTH_SHIFT),

	COLORMODE_GRAYw		 = (COLORMODE_GRAY | (BITDEPTH_UWORD << BITDEPTH_SHIFT)),
	COLORMODE_AGRAYw	 = (COLORMODE_AGRAY | (BITDEPTH_UWORD << BITDEPTH_SHIFT)),
	COLORMODE_RGBw		 = (COLORMODE_RGB | (BITDEPTH_UWORD << BITDEPTH_SHIFT)),
	COLORMODE_ARGBw		 = (COLORMODE_ARGB | (BITDEPTH_UWORD << BITDEPTH_SHIFT)),
	COLORMODE_MASKw		 = (COLORMODE_MASK | (BITDEPTH_UWORD << BITDEPTH_SHIFT)),

	// 32 bit modes
	COLORMODE_ILLEGALf = (BITDEPTH_FLOAT << BITDEPTH_SHIFT),

	COLORMODE_GRAYf		 = (COLORMODE_GRAY | (BITDEPTH_FLOAT << BITDEPTH_SHIFT)),
	COLORMODE_AGRAYf	 = (COLORMODE_AGRAY | (BITDEPTH_FLOAT << BITDEPTH_SHIFT)),
	COLORMODE_RGBf		 = (COLORMODE_RGB | (BITDEPTH_FLOAT << BITDEPTH_SHIFT)),
	COLORMODE_ARGBf		 = (COLORMODE_ARGB | (BITDEPTH_FLOAT << BITDEPTH_SHIFT)),
	COLORMODE_MASKf		 = (COLORMODE_MASK | (BITDEPTH_FLOAT << BITDEPTH_SHIFT))
} mixin ENUM_END_FLAGS!(COLORMODE);

enum COLORSPACETRANSFORMATION
{
	COLORSPACETRANSFORMATION_NONE						= 0,
	COLORSPACETRANSFORMATION_LINEAR_TO_SRGB	= 1,
	COLORSPACETRANSFORMATION_SRGB_TO_LINEAR	= 2,

	COLORSPACETRANSFORMATION_LINEAR_TO_VIEW	= 10,
	COLORSPACETRANSFORMATION_SRGB_TO_VIEW		= 11
} mixin ENUM_END_LIST!(COLORSPACETRANSFORMATION);

enum PIXELCNT
{
	PIXELCNT_0									 = 0,
	PIXELCNT_DITHERING					 = (1 << 0),	// allow dithering
	PIXELCNT_B3DLAYERS					 = (1 << 1),	// merge b3d layers (multipassbmp)
	PIXELCNT_APPLYALPHA					 = (1 << 2),	// apply alpha layers to the result (paintlayer)
	PIXELCNT_INTERNAL_SETLINE		 = (1 << 29),	// PRIVATE! internal setline indicator
	PIXELCNT_INTERNAL_ALPHAVALUE = (1 << 30)	// PRIVATE! get also the alphavalue (rgba 32 bit)
} mixin ENUM_END_FLAGS!(PIXELCNT);

enum INITBITMAPFLAGS
{
	INITBITMAPFLAGS_0					= 0,
	INITBITMAPFLAGS_GRAYSCALE	= (1 << 0),
	INITBITMAPFLAGS_SYSTEM		= (1 << 1)
} mixin ENUM_END_FLAGS!(INITBITMAPFLAGS);

enum MPB_GETLAYERS
{
	MPB_GETLAYERS_0			= 0,
	MPB_GETLAYERS_ALPHA	= (1 << 1),
	MPB_GETLAYERS_IMAGE	= (1 << 2)
} mixin ENUM_END_FLAGS!(MPB_GETLAYERS);

enum MPBTYPE
{
	MPBTYPE_SHOW			 = 1000,	// Bool, get, set
	MPBTYPE_SAVE			 = 1001,	// Bool, get, set
	MPBTYPE_PERCENT		 = 1002,	// Float, get, set
	MPBTYPE_BLENDMODE	 = 1003,	// Int32, get, set
	MPBTYPE_COLORMODE	 = 1004,	// Int32, get, set
	MPBTYPE_BITMAPTYPE = 1005,	// Int32, get
	MPBTYPE_NAME			 = 1006,	// String, get, set
	MPBTYPE_DPI				 = 1007,	// Int32, get, set
	MPBTYPE_USERID		 = 1008,	// Int32, get, set
	MPBTYPE_USERSUBID	 = 1009,	// Int32, get, set
	MPBTYPE_FORCEBLEND = 1010		// Int32, get, set		(special mode used to force blend layers)
} mixin ENUM_END_LIST!(MPBTYPE);

enum LENGTHUNIT
{
	LENGTHUNIT_PIXEL = 0,
	LENGTHUNIT_KM		 = 1,
	LENGTHUNIT_M		 = 2,
	LENGTHUNIT_CM		 = 3,
	LENGTHUNIT_MM		 = 4,
	LENGTHUNIT_UM		 = 5,
	LENGTHUNIT_NM		 = 6,
	LENGTHUNIT_MILE	 = 7,
	LENGTHUNIT_YARD	 = 8,
	LENGTHUNIT_FEET	 = 9,
	LENGTHUNIT_INCH	 = 10
} mixin ENUM_END_LIST!(LENGTHUNIT);

enum SPLINETYPE
{
	SPLINETYPE_LINEAR	 = 0,
	SPLINETYPE_CUBIC	 = 1,
	SPLINETYPE_AKIMA	 = 2,
	SPLINETYPE_BSPLINE = 3,
	SPLINETYPE_BEZIER	 = 4
} mixin ENUM_END_LIST!(SPLINETYPE);

// particle bits
enum PARTICLEFLAGS
{
	PARTICLEFLAGS_0				= 0,
	PARTICLEFLAGS_VISIBLE	= (1 << 0),
	PARTICLEFLAGS_ALIVE		= (1 << 1)
} mixin ENUM_END_FLAGS!(PARTICLEFLAGS);

// baselist N-bits
enum NBIT
{
	NBIT_0					 = 0,

	NBIT_TL1_FOLD		 = 1,
	NBIT_TL2_FOLD		 = 2,
	NBIT_TL3_FOLD		 = 3,
	NBIT_TL4_FOLD		 = 4,

	NBIT_TL1_SELECT	 = 5,
	NBIT_TL2_SELECT	 = 6,
	NBIT_TL3_SELECT	 = 7,
	NBIT_TL4_SELECT	 = 8,

	NBIT_TL1_TDRAW	 = 9,
	NBIT_TL2_TDRAW	 = 10,
	NBIT_TL3_TDRAW	 = 11,
	NBIT_TL4_TDRAW	 = 12,

	NBIT_CKEY_ACTIVE = 13,	// active point of animation path in editor

	NBIT_OM1_FOLD		 = 14,
	NBIT_OM2_FOLD		 = 15,
	NBIT_OM3_FOLD		 = 16,
	NBIT_OM4_FOLD		 = 17,

	// defines if the tracks of the object are shown
	NBIT_TL1_FOLDTR						= 18,
	NBIT_TL2_FOLDTR						= 19,
	NBIT_TL3_FOLDTR						= 20,
	NBIT_TL4_FOLDTR						= 21,

	NBIT_TL1_FOLDFC						= 22,
	NBIT_TL2_FOLDFC						= 23,
	NBIT_TL3_FOLDFC						= 24,
	NBIT_TL4_FOLDFC						= 25,

	NBIT_SOURCEOPEN						= 26,

	NBIT_TL1_HIDE							= 27,
	NBIT_TL2_HIDE							= 28,
	NBIT_TL3_HIDE							= 29,
	NBIT_TL4_HIDE							= 30,

	NBIT_SOLO_ANIM						= 31,
	NBIT_SOLO_LAYER						= 32,

	NBIT_TL1_SELECT2					= 33,
	NBIT_TL2_SELECT2					= 34,
	NBIT_TL3_SELECT2					= 35,
	NBIT_TL4_SELECT2					= 36,

	NBIT_SOLO_MOTION					= 37,

	NBIT_CKEY_LOCK_T					= 38,
	NBIT_CKEY_LOCK_V					= 39,
	NBIT_CKEY_MUTE						= 40,
	NBIT_CKEY_CLAMP						= 41,

	NBIT_CKEY_BREAK						= 42,
	NBIT_CKEY_KEEPVISUALANGLE = 43,

	NBIT_CKEY_LOCK_O					= 44,
	NBIT_CKEY_LOCK_L					= 45,
	NBIT_CKEY_AUTO						= 46,
	NBIT_CKEY_ZERO_O_OLD			= 48,
	NBIT_CKEY_ZERO_L_OLD			= 49,

	NBIT_TL1_FCSELECT					= 50,
	NBIT_TL2_FCSELECT					= 51,
	NBIT_TL3_FCSELECT					= 52,
	NBIT_TL4_FCSELECT					= 53,

	NBIT_CKEY_BREAKDOWN				= 54,

	NBIT_TL1_FOLDMOTION				= 55,
	NBIT_TL2_FOLDMOTION				= 56,
	NBIT_TL3_FOLDMOTION				= 57,
	NBIT_TL4_FOLDMOTION				= 58,

	NBIT_TL1_SELECTMOTION			= 59,
	NBIT_TL2_SELECTMOTION			= 60,
	NBIT_TL3_SELECTMOTION			= 61,
	NBIT_TL4_SELECTMOTION			= 62,

	NBIT_OHIDE								= 63,	// Hide object in OM
	NBIT_TL_TBAKE							= 64,

	NBIT_TL1_FOLDSM						= 66,
	NBIT_TL2_FOLDSM						= 67,
	NBIT_TL3_FOLDSM						= 68,
	NBIT_TL4_FOLDSM						= 69,

	NBIT_SUBOBJECT						= 70,
	NBIT_LINK_ACTIVE					= 71,
	NBIT_THIDE								= 72,	// hide in TL
	NBIT_SUBOBJECT_AM					= 74,
	NBIT_PROTECTION						= 75,	// psr protected
	NBIT_NOANIM								= 76,	// no animation
	NBIT_NOSELECT							= 77,	// no selection
	NBIT_EHIDE								= 78,	// hide in viewport
	NBIT_REF									= 79,	// x-ref
	NBIT_REF_NO_DD						= 80,	// x-ref private
	NBIT_REF_OHIDE						= 81,	// x-ref private
	NBIT_NO_DD								= 82,	// disallow duplication/d&d

	NBIT_MAX									= 83,
	NBIT_PRIVATE_MASK1				= -1,
	NBIT_PRIVATE_MASK2				= -2,
	NBIT_PRIVATE_MASK3				= -3,
	NBIT_PRIVATE_MASK4				= -4
} mixin ENUM_END_LIST!(NBIT);

enum CREATEJOBRESULT
{
	CREATEJOBRESULT_OK							= 0,
	CREATEJOBRESULT_OUTOFMEMORY			= 1,
	CREATEJOBRESULT_ASSETMISSING		= 2,
	CREATEJOBRESULT_SAVINGFAILED		= 3,
	CREATEJOBRESULT_REPOSITORYERROR	= 4
} mixin ENUM_END_FLAGS!(CREATEJOBRESULT);

enum NBITCONTROL
{
	NBITCONTROL_SET							= 1,
	NBITCONTROL_CLEAR						= 2,
	NBITCONTROL_TOGGLE					= 3,
	NBITCONTROL_PRIVATE_NODIRTY	= 0xf0
} mixin ENUM_END_FLAGS!(NBITCONTROL);

// baselist bits
enum BIT_ACTIVE =	(1 << 1);
enum BIT_ACTIVE2 =	(1 << 29);

// material bits
enum BIT_MATMARK =				(1 << 2);	// marked material
enum BIT_ENABLEPAINT =		(1 << 3);	// enable painting
enum BIT_RECALCPREVIEW =	(1 << 5);	// recalculate preview
enum BIT_MFOLD =					(1 << 6);	// folded in material manager
enum BIT_BP_FOLDLAYERS =	(1 << 9);	// fold layers in material manger

// object bits
enum BIT_IGNOREDRAW =										 (1 << 2);		// ignore object during draw
enum BIT_OFOLD =													 (1 << 6);		// folded in object manager
enum BIT_CONTROLOBJECT =									 (1 << 9);		// control object
enum BIT_RECMARK =												 (1 << 11);	// help bit for recursive operations
enum BIT_IGNOREDRAWBOX =									 (1 << 12);	// ignore box drawing object
enum BIT_EDITOBJECT =										 (1 << 13);	// edit object from sds
enum BIT_ACTIVESELECTIONDRAW =						 (1 << 15);	// draw active selection
enum BIT_TEMPDRAW_VISIBLE_CACHECHILD =		 (1 << 16);	// private, temp bits for faster redraw
enum BIT_TEMPDRAW_VISIBLE_DEFCACHECHILD = (1 << 17);	// private, temp bits for faster redraw
enum BIT_TEMPDRAW_VISIBLE_CHILD =				 (1 << 18);	// private, temp bits for faster redraw
enum BIT_HIGHLIGHT =											 (1 << 20);	// object highlighted in viewport
enum BIT_FORCE_UNOPTIMIZED =							 (1 << 21);	// do not optimize the points of a polygon object during OGl redraw

// track bits
enum BIT_TRACKPROCESSED =				(1 << 16);	// track has been processed, avoid recursions
enum BIT_ANIM_OFF =							(1 << 17);	// is sequence inactive
enum BIT_ANIM_SOLO =							(1 << 18);
enum BIT_ANIM_CONSTANTVELOCITY =	(1 << 19);

// videopost bits
enum BIT_VPDISABLED = (1 << 2);	// videopost effect is disabled

// document bits
enum BIT_DOCUMENT_CHECKREWIND = (1 << 2);	// doc needs to check for a rewind

// renderdata bits
enum BIT_ACTIVERENDERDATA = (1 << 28);

// object info
enum OBJECT_MODIFIER =					 (1 << 0);
enum OBJECT_HIERARCHYMODIFIER = (1 << 1);
enum OBJECT_GENERATOR =				 (1 << 2);
enum OBJECT_INPUT =						 (1 << 3);
enum OBJECT_PARTICLEMODIFIER =	 (1 << 5);
enum OBJECT_NOCACHESUB =				 (1 << 6);
enum OBJECT_ISSPLINE =					 (1 << 7);
enum OBJECT_UNIQUEENUMERATION = (1 << 8);
enum OBJECT_CAMERADEPENDENT =	 (1 << 9);
enum OBJECT_USECACHECOLOR =		 (1 << 10);
enum OBJECT_POINTOBJECT =			 (1 << 11);
enum OBJECT_POLYGONOBJECT =		 (1 << 12);
enum OBJECT_NO_PLA =						 (1 << 13);
enum OBJECT_DONTFREECACHE =		 (1 << 14);
enum OBJECT_CALL_ADDEXECUTION = (1 << 15);

///////////////////ID's/////////////////////

// list elements
enum Tbaselist2d =		110050;
enum Tbasedocument =	110059;
enum Tpluginlayer =	110064;
enum Tundoablelist =	110068;
enum Tgelistnode =		110069;

// materials
enum Mbase =				5702;
enum Mmaterial =		5703;
enum Mplugin =			5705;
enum Mfog =				8803;
enum Mterrain =		8808;
enum Mdanel =			1011117;
enum Mbanji =			1011118;
enum Mbanzi =			1011119;
enum Mcheen =			1011120;
enum Mmabel =			1011121;
enum Mnukei =			1011122;
enum MCgFX =				450000237;
enum Marchigrass =	1028461;	// Architectural Grass Material

// videopost
enum VPbase = 5709;

// objects
enum Opolygon =					5100;
enum Ospline =						5101;
enum Olight =						5102;
enum Ocamera =						5103;
enum Ofloor =						5104;
enum Osky =							5105;
enum Oenvironment =			5106;
enum Oloft =							5107;
enum Offd =							5108;
enum Oparticle =					5109;
enum Odeflector =				5110;
enum Ogravitation =			5111;
enum Orotation =					5112;
enum Owind =							5113;
enum Ofriction =					5114;
enum Oturbulence =				5115;
enum Oextrude =					5116;
enum Olathe =						5117;
enum Osweep =						5118;
enum Oattractor =				5119;
enum Obezier =						5120;
enum Oforeground =				5121;
enum Obackground =				5122;
enum Obone_EX =					5123;
enum Odestructor =				5124;
enum Ometaball =					5125;
enum Oinstance =					5126;
enum Obend =							5128;
enum Obulge =						5129;
enum Oshear =						5131;
enum Otaper =						5133;
enum Otwist =						5134;
enum Owave =							5135;
enum Ostage =						5136;
enum Oline =							5137;
enum Omicrophone =				5138;
enum Oloudspeaker =			5139;
enum Onull =							5140;
enum Osymmetry =					5142;
enum Owrap =							5143;
enum Oboole =						1010865;
enum Oexplosion =				5145;
enum Oformula =					5146;
enum Omelt =							5147;
enum Oshatter =					5148;
enum Owinddeform =				5149;
enum Oarray =						5150;
enum Oheadphone =				5151;
enum Oworkplane =				5153;
enum Oplugin =						5154;
enum Obase =							5155;	// for instanceof!
enum Opoint =						5156;	// for instanceof!
enum Obasedeform =				5157;	// for instanceof!
enum Oparticlemodifier =	5158;	// for instanceof!
enum Opolyreduction =		1001253;
enum Oshowdisplacement =	1001196;
enum Ojoint =						1019362;
enum Oskin =							1019363;
enum Oweighteffector =		1019677;
enum Ocharacter =				1021433;
enum Ocmotion =					1021824;
enum Oxref =							1025766;
enum Ocube =							5159;
enum Osphere =						5160;
enum Oplatonic =					5161;
enum Ocone =							5162;
enum Otorus =						5163;
enum Odisc =							5164;
enum Otube =							5165;
enum Ofigure =						5166;
enum Opyramid =					5167;
enum Oplane =						5168;
enum Ofractal =					5169;
enum Ocylinder =					5170;
enum Ocapsule =					5171;
enum Ooiltank =					5172;
enum Orelief =						5173;
enum Osinglepoly =				5174;

enum Opluginpolygon = 1001091;

// spline primitive objects
enum Osplineprimitive = 5152;	// base description
enum Osplineprofile =	 5175;
enum Osplineflower =		 5176;
enum Osplineformula =	 5177;
enum Osplinetext =			 5178;
enum Osplinenside =		 5179;
enum Ospline4side =		 5180;
enum Osplinecircle =		 5181;
enum Osplinearc =			 5182;
enum Osplinecissoid =	 5183;
enum Osplinecycloid =	 5184;
enum Osplinehelix =		 5185;
enum Osplinerectangle = 5186;
enum Osplinestar =			 5187;
enum Osplinecogwheel =	 5188;
enum Osplinecontour =	 5189;

enum Oselection =				5190;
enum Osds =							1007455;
enum Osplinedeformer =		1008982;
enum Osplinerail =				1008796;
enum Oatomarray =				1001002;
enum Ospherify =					1001003;
enum Oexplosionfx =			1002603;
enum Oconnector =				1011010;
enum Oalembicgenerator = 1028083;

// small listnode plugin
enum Yplugin =	110061;

// big listnode plugin
enum Zplugin =	110062;

// DLayerStruct object
enum Olayer = 100004801;

// (virtual) filter base
enum Fbase =	1001024;

// multipass render settings element
enum Zmultipass = 300001048;

enum SHplugin = 110065;
enum VPplugin = 110066;

// listhead
enum ID_LISTHEAD =	110063;

// render data
enum Rbase = 110304;

// shader plugins
enum Xbase =							5707;
enum Xcolor =						5832;
enum Xbitmap =						5833;
enum Xbrick =						5804;
enum Xcheckerboard =			5800;
enum Xcloud =						5802;
enum Xcolorstripes =			5822;
enum Xcyclone =					5821;
enum Xearth =						5825;
enum Xfire =							5803;
enum Xflame =						5817;
enum Xgalaxy =						5813;
enum Xmetal =						5827;
enum Xsimplenoise =			5807;
enum Xrust =							5828;
enum Xstar =							5816;
enum Xstarfield =				5808;
enum Xsunburst =					5820;
enum Xsimpleturbulence =	5806;
enum Xvenus =						5826;
enum Xwater =						5818;
enum Xwood =							5823;
enum Xplanet =						5829;
enum Xmarble =						5830;
enum Xspectral =					5831;
enum Xgradient =					1011100;
enum Xfalloff =					1011101;
enum Xtiles =						1011102;
enum Xfresnel =					1011103;
enum Xlumas =						1011105;
enum Xproximal =					1011106;
enum Xnormaldirection =	1011107;
enum Xtranslucency =			1011108;
enum Xfusion =						1011109;
enum Xposterizer =				1011111;
enum Xcolorizer =				1011112;
enum Xdistorter =				1011114;
enum Xprojector =				1011115;
enum Xnoise =						1011116;
enum Xlayer =						1011123;
enum Xspline =						1011124;
enum Xfilter =						1011128;
enum Xripple =						1011199;
enum Xvertexmap =				1011137;
enum Xsss =							1001197;
enum Xambientocclusion =	1001191;
enum Xchanlum =					1007539;
enum Xmosaic =						1022119;
enum Xxmbsubsurface =		1025614;
enum Xrainsampler =			1026576;
enum Xnormalizer =				1026588;
enum Xreference =				1027315;
enum Xxmbreflection =		1027741;
enum Xterrainmask =			1026277;


// tags
enum Tpoint =						5600;
enum Tanchor_EX =				5608;
enum Tphong =						5612;
enum Tdisplay =					5613;
enum Tkinematic_EX =			5614;
enum Ttexture =					5616;
enum Ttangent =					5617;
enum Tprotection =				5629;
enum Tparticle =					5630;
enum Tmotionblur =				5636;
enum Tcompositing =			5637;
enum Twww =							5647;
enum Tsavetemp =					5650;
enum Tpolygon =					5604;
enum Tuvw =							5671;
enum Tsegment =					5672;
enum Tpolygonselection =	5673;
enum Tpointselection =		5674;
enum Tcoffeeexpression =	5675;
enum Ttargetexpression =	5676;
enum Tfixexpression_EX =	5677;
enum Tsunexpression =		5678;
enum Tikexpression_EX =	5679;
enum Tline =							5680;
enum Tvertexmap =				5682;
enum Trestriction =			5683;
enum Tmetaball =					5684;
enum Tbakeparticle =			5685;
enum Tmorph =						5689;
enum Tsticktexture =			5690;
enum Tplugin =						5691;
enum Tstop =							5693;
enum Tbase =							5694;	// for instanceof
enum Tvariable =					5695;	// for instanceof
enum Tvibrate =					5698;
enum Taligntospline =		5699;
enum Taligntopath =			5700;
enum Tedgeselection =		5701;
enum Tclaudebonet_EX =		5708;
enum Tnormal =						5711;
enum Tcorner =						5712;
enum Tsds =							1007579;
enum Tlookatcamera =			1001001;
enum Texpresso =					1001149;
enum Tsoftselection =		1016641;
enum Tbaketexture =			1011198;
enum Tsdsdata =					1018016;
enum Tweights =					1019365;
enum Tposemorph =				1024237;
enum Tpython =						1022749;
enum Tsculpt =						1023800;
enum Tmotioncam =				1027742;	// Motion Camera Tag
enum Tmorphcam =					1027743;	// Morph Camera Tag
enum Tcrane =						1028270;	// Camera Crane Tag
enum Tarchigrass =				1028463;	// Architectural Grass Tag
enum Tsculptnormals =		1027660; // Private for sculpting

// new anim system
enum NLAbase =	5349;	// nla system
enum CTbase =	5350;	// anim system
enum CSbase =	5351;
enum CKbase =	5352;

enum CTpla =		100004812;
enum CTsound =	100004813;
enum CTmorph =	100004822;
enum CTtime =	-1;

enum TL_MARKEROBJ = 465001514;

enum ID_MACHINE =			300002140;
enum ID_MACHINEGROUP =	300002142;

enum GVbase = 1001101;

enum ID_BS_HOOK = 100004808;

// modeling commands
enum MCOMMAND_SPLINE_HARDINTERPOLATION =	100;
enum MCOMMAND_SPLINE_SOFTINTERPOLATION =	101;
enum MCOMMAND_SPLINE_REORDER =						102;
enum MCOMMAND_SPLINE_REVERSE =						103;
enum MCOMMAND_SPLINE_MOVEDOWN =					104;
enum MCOMMAND_SPLINE_MOVEUP =						105;
enum MCOMMAND_SPLINE_JOINSEGMENT =				109;
enum MCOMMAND_SPLINE_BREAKSEGMENT =			110;
enum MCOMMAND_SPLINE_EQUALLENGTH =				111;
enum MCOMMAND_SPLINE_EQUALDIRECTION =		112;
enum MCOMMAND_SPLINE_LINEUP =						113;
enum MCOMMAND_SPLINE_CREATEOUTLINE =			114;
enum MCOMMAND_SPLINE_PROJECT =						115;
enum MCOMMAND_SPLINE_ADDPOINT =					116;
enum MCOMMAND_SELECTALL =								200;
enum MCOMMAND_DESELECTALL =							201;
enum MCOMMAND_SELECTINVERSE =						202;
enum MCOMMAND_SELECTCONNECTED =					203;
enum MCOMMAND_SELECTGROW =								204;
enum MCOMMAND_SELECTSHRINK =							205;
enum MCOMMAND_SELECTPOINTTOPOLY =				206;
enum MCOMMAND_SELECTPOLYTOPOINT =				207;
enum MCOMMAND_SELECTADJACENT =						208;
enum MCOMMAND_GENERATESELECTION =				209;
enum MCOMMAND_HIDESELECTED =							211;
enum MCOMMAND_HIDEUNSELECTED =						212;
enum MCOMMAND_HIDEINVERT =								213;
enum MCOMMAND_UNHIDE =										214;
enum MCOMMAND_REVERSENORMALS =						217;
enum MCOMMAND_ALIGNNORMALS =							218;
enum MCOMMAND_SPLIT =										220;
enum MCOMMAND_TRIANGULATE =							221;
enum MCOMMAND_UNTRIANGULATE =						222;
enum MCOMMAND_DELETE =										224;
enum MCOMMAND_OPTIMIZE =									227;
enum MCOMMAND_DISCONNECT =								228;
enum MCOMMAND_MAKEEDITABLE =							230;
enum MCOMMAND_MIRROR =										237;
enum MCOMMAND_MATRIXEXTRUDE =						238;
enum MCOMMAND_SUBDIVIDE =								242;
enum MCOMMAND_EXPLODESEGMENTS =					243;
enum MCOMMAND_KNIFE =										244;
enum MCOMMAND_CURRENTSTATETOOBJECT =			245;
enum MCOMMAND_JOIN =											246;
enum MCOMMAND_CONVERTSELECTION =					247;
enum MCOMMAND_EDGE_TO_SPLINE =						251;
enum MCOMMAND_BREAKPHONG =								255;
enum MCOMMAND_UNBREAKPHONG =							256;
enum MCOMMAND_PHONGTOSELECTION =					257;
enum MCOMMAND_MELT =											264;
enum MCOMMAND_RESETSYSTEM =							265;

// container data for modeling commands
enum MDATA_SPLINE_FREEHANDTOLERANCE =					 2020;	// REAL
enum MDATA_SPLINE_OUTLINE =										 2021;	// REAL
enum MDATA_SPLINE_PROJECTMODE =								 2022;	// Int32
enum MDATA_SPLINE_ADDPOINTSEGMENT =						 2023;	// Int32
enum MDATA_SPLINE_ADDPOINTPOSITION =						 2024;	// REAL
enum MDATA_SPLINE_ADDPOINTSELECT =							 2025;
enum MDATA_DISCONNECT_PRESERVEGROUPS =					 2028;	// BOOL
enum MDATA_MIRROR_SNAPPOINTS =									 2069;	// BOOL
enum MDATA_MIRROR_DUPLICATE =									 2070;	// BOOL
enum MDATA_MIRROR_WELD =												 2071;	// BOOL
enum MDATA_MIRROR_TOLERANCE =									 2072;	// REAL
enum MDATA_MIRROR_SYSTEM =											 2067;	// Int32
enum MDATA_MIRROR_PLANE =											 2068;	// Int32
enum MDATA_MIRROR_VALUE =											 2073;	// REAL
enum MDATA_MIRROR_POINT =											 2074;	// VECTOR
enum MDATA_MIRROR_VECTOR =											 2075;	// VECTOR
enum MDATA_OPTIMIZE_TOLERANCE =								 2076;	// REAL
enum MDATA_OPTIMIZE_POINTS =										 2077;	// BOOL
enum MDATA_OPTIMIZE_POLYGONS =									 2078;	// BOOL
enum MDATA_OPTIMIZE_UNUSEDPOINTS =							 2079;	// BOOL
enum MDATA_SPLINE_OUTLINESEPARATE =						 2080;	// BOOL
enum MDATA_CROSSSECTION_ANGLE =								 2082;	// REAL
enum MDATA_SUBDIVIDE_HYPER =										 2098;	// BOOL
enum MDATA_SUBDIVIDE_ANGLE =										 2099;	// REAL
enum MDATA_SUBDIVIDE_SPLINESUB =								 2100;	// Int32
enum MDATA_SUBDIVIDE_SUB =											 2101;	// Int32
enum MDATA_KNIFE_P1 =													 2110;	// VECTOR - only for send command
enum MDATA_KNIFE_V1 =													 2111;	// VECTOR - only for send command
enum MDATA_KNIFE_P2 =													 2112;	// VECTOR - only for send command
enum MDATA_KNIFE_V2 =													 2113;	// VECTOR - only for send command
enum MDATA_KNIFE_ANGLE =												 2115;	// REAL
enum MDATA_MIRROR_SELECTIONS =									 2120;	// BOOL
enum MDATA_UNTRIANGULATE_ANGLE =								 2121;	// BOOL
enum MDATA_MIRROR_ONPLANE =										 2122;	// BOOL
enum MDATA_CONVERTSELECTION_LEFT =							 2126;	// Int32
enum MDATA_CONVERTSELECTION_RIGHT =						 2127;	// Int32
enum MDATA_CONVERTSELECTION_TOLERANT =					 2128;	// BOOL
enum MDATA_CURRENTSTATETOOBJECT_INHERITANCE =	 2140;	// BOOL
enum MDATA_CURRENTSTATETOOBJECT_KEEPANIMATION = 2141;	// BOOL
enum MDATA_ROTATECAMERA =											 2142;	// BOOL
enum MDATA_RING_EDGE =													 2154;	// Int32
enum MDATA_RING_SELECTION =										 2155;	// Int32 (must be SELECTION_NEW, SELECTION_ADD or SELECTION_SUB)
enum MDATA_RING_SKIP =													 2156;	// Int32
enum MDATA_FILLSEL_START_POLY =								 2157;	// Int32
enum MDATA_FILLSEL_SELECTION =									 2158;	// Int32 (must be SELECTION_NEW, SELECTION_ADD or SELECTION_SUB)
enum MDATA_OUTLINESEL_START_POLY =							 2159;	// Int32
enum MDATA_OUTLINESEL_SELECTION =							 2160;	// Int32 (must be SELECTION_NEW, SELECTION_ADD or SELECTION_SUB)
enum MDATA_UNTRIANGULATE_NGONS =								 2143;	// BOOL
enum MDATA_UNTRIANGULATE_ANGLE_RAD =						 2161;	// REAL
enum MDATA_CURRENTSTATETOOBJECT_NOGENERATE =		 2162;	// BOOL
enum MDATA_RESETSYSTEM_COMPENSATE =						 2165;	// BOOL
enum MDATA_RESETSYSTEM_RECURSIVE =							 2166;	// BOOL
enum MDATA_JOIN_MERGE_SELTAGS =								 2167;	// BOOL

enum MDATA_SETVERTEX_VALUE =	4000;										// REAL
enum MDATA_SETVERTEX_MODE =	4001;										// Int32

// world preferences
enum WPREF_UNITS_BASIC =				10000;			// Int32
enum WPREF_UNITS_TIME =				10001;			// Int32
enum WPREF_UNITS_AUTOCONVERT = 10002;			// BOOL
enum WPREF_UNITS_USEUNITS =		10003;			// BOOL
enum WPREF_REFRESHTIME =				10004;			// Int32
enum WPREF_RATIO =							10005;			// REAL

enum WPREF_CENTER =								1002;	// BOOL
enum WPREF_TABLET =								1005;	// BOOL
enum WPREF_OPENGL =								1008;	// BOOL
enum WPREF_LINK_SELECTION =				1009;	// BOOL
enum WPREF_FULLANIMREDRAW =				1010;	// BOOL
enum WPREF_SAVE_LAYOUT =						1014;	// BOOL
enum WPREF_INSERTAT =							1016;	// Int32
enum WPREF_PASTEAT =								1017;	// Int32
enum WPREF_MAX_UNDOS =							1018;	// Int32
enum WPREF_MAX_LAST =							1019;	// Int32
enum WPREF_CAMERAROTATION =				1020;	// Int32
enum WPREF_CAMERAROTATION_CENTER =	1;
enum WPREF_CAMERAROTATION_OBJECT =	2;
enum WPREF_CAMERAROTATION_CURSOR =	3;
enum WPREF_CAMERAROTATION_CAMERA =	4;
enum WPREF_CAMERAROTATION_CUSTOM =	5;

enum WPREF_DOLLYTOCURSOR =	1021;													// Int32
enum WPREF_SYNCVIEWPORTS =	1022;													// BOOL 440000085 // BOOL

enum WPREF_OPENGL_PERSPECT =												 1024;	// BOOL
enum WPREF_OPENGL_TEXTURE_FILTERING =							 1025;	// Int32
enum WPREF_OPENGL_TEXTURE_FILTERING_NEAREST =			 0;
enum WPREF_OPENGL_TEXTURE_FILTERING_LINEAR =				 1;
enum WPREF_OPENGL_TEXTURE_FILTERING_LINEAR_MIPMAP = 2;
enum WPREF_USE_TEXTURES =													 1026;	// BOOL
enum WPREF_NAV_POI_MODE =													 1027;	// Int32
enum WPREF_NAV_POI_CENTER =												 1;
enum WPREF_NAV_POI_OBJECT =												 2;
enum WPREF_NAV_POI_CAMERA =												 3;

enum WPREF_NAV_CURSOR_MODE =			 1028;	// Int32
enum WPREF_NAV_CURSOR_OFF =			 1;
enum WPREF_NAV_CURSOR_SELECTION = 2;
enum WPREF_NAV_CURSOR_CHILDREN =	 3;
enum WPREF_NAV_CURSOR_ALL =			 4;

enum WPREF_USE_QUICKTIME =										1029;	// BOOL
enum WPREF_TABLET_HIRES =										1030;	// BOOL
enum WPREF_REVERSE_ORBIT =										1031;	// Bool
enum WPREF_NAV_CURSOR_DEEP =									1032;	// Bool
enum WPREF_NAV_LOCK_POI =										1033;	// Bool
enum WPREF_OPENGL_POLYLINES =								1034;	// Bool: use polylines
enum WPREF_OPENGL_LIGHTING =									1035;	// Bool: use opengl lighting
enum WPREF_OPENGL_GLPOINTS =									1037;	// Bool: allow real gl points
enum WPREF_OPENGL_HIGHENDSHADING =						1038;	// Bool
enum WPREF_NAV_VIEW_TRANSITION =							1039;	// Bool
enum WPREF_REALTIMEMANAGER =									1042;	// BOOL
enum WPREF_MAX_BACKUP =											1043;	// Int32
enum WPREF_CENTERAXIS =											1044;	// BOOL
enum WPREF_OPENGL_DUALPLANES_ARB =						1047;	// Bool: use dualplane ARB extension
enum WPREF_MATPREVIEW_DEFAULTSIZE =					1048;	// Int32
enum WPREF_DESCRIPTIONLIMIT =								1049;	// Int32
enum WPREF_MATPREVIEW_DEFAULTOBJECT_MAT =		1050;	// Int32
enum WPREF_MATPREVIEW_DEFAULTUSERSCENE_MAT =	1051;	// String
enum WPREF_MATPREVIEW_DEFAULTOBJECT_SHD =		1052;	// Int32
enum WPREF_MATPREVIEW_DEFAULTUSERSCENE_SHD =	1053;	// String
enum WPREF_MATPREVIEW_AUTO_UPDATE =					1054;	// Bool
enum WPREF_MATPREVIEW_REDRAW_TIME =					1055;	// Int32: max. redraw time in ms
enum WPREF_MATPREVIEW_FPS =									1056;	// Int32
enum WPREF_MATPREVIEW_LENGTH =								1057;	// Float
enum WPREF_MATPREVIEW_MAX_MEM =							1058;	// Int32
enum WPREF_SUBPIXELLIMIT =										1062;	// Int32
enum WPREF_OPENGL_ROTATEQUADS =							1064;	// BOOL: rotate quads 90 degree to get another subdivision
enum WPREF_OPENGL_DUALPLANES_HIGHLIGHT =			1066;	// Bool: allow dualplanes in glmode (gl extension)
enum WPREF_ALLOWBUGREPORTS =									1068;	// Bool
//#define WPREF_OPENGL_HIGHQUALITY							1069 // BOOL
enum WPREF_OPENGL_COMPILER =					1070;					// Int32
enum WPREF_OPENGL_COMPILER_GLSL =		0;
enum WPREF_OPENGL_COMPILER_CG =			1;
enum WPREF_OPENGL_MAX_TRANS_DEPTH =	1071;	// Int32
enum WPREF_OPENGL_MAX_LIGHTS =				1072;	// Int32
enum WPREF_OPENGL_MAX_SHADOWS =			1073;	// Int32
enum WPREF_SAVE_CACHES =							1074;	// BOOL
enum WPREF_SAVE_CACHES_ANIM =				1075;	// BOOL
enum WPREF_OPENGL_ANTIALIAS =				1084;	// Int32
enum WPREF_OPENGL_MULTITHREADED =		1085;	// Bool
enum WPREF_OPENGL_USE_SHADER_CACHE =	1089;	// Bool
enum WPREF_VIEW_DISLAYCOLORPROFILE =	1086;	// ColorProfile CustomDataType

enum WPREF_MOVEACCELERATION =	 1081;				// REAL
enum WPREF_SCALEACCELERATION =	 1082;				// REAL
enum WPREF_ROTATEACCELERATION = 1083;				// REAL

enum WPREF_GLOBAL_SCRIPTMODE =	1090;				// Int32 (SCRIPTMODE)

enum WPREF_COLOR_SYSTEM_C4D =		1100;			// Int32
enum WPREF_COLOR_SYSTEM_BP =			1101;			// Int32
enum COLORSYSTEM_HSVTAB =				22;
enum COLORSYSTEM_TABLE =					30;
enum COLORSYSTEM_RGB_COLOR =			11;
enum COLORSYSTEM_HSV_COLOR =			21;
enum WPREF_COLOR_RGBRANGE =			1102;	// Int32
enum WPREF_COLOR_HRANGE =				1103;	// Int32
enum WPREF_COLOR_SVRANGE =				1104;	// Int32
enum COLORSYSTEM_RANGE_PERCENT =	0;
enum COLORSYSTEM_RANGE_DEGREE =	3;
enum COLORSYSTEM_RANGE_255 =			1;
enum COLORSYSTEM_RANGE_65535 =		2;
enum WPREF_COLOR_QUICK_C4D =			1105;
enum WPREF_COLOR_QUICK_BP =			1106;
enum WPREF_COLOR_MIX_C4D =				1107;
enum WPREF_COLOR_MIX_BP =				1108;
enum WPREF_COLOR_SETUPS =				1109;				// BaseContainer

enum WPREF_COLOR_QUICKPRESET =					1200;	// Vector
enum WPREF_COLOR_QUICKPRESET_LAST =		1299;	// Vector
enum WPREF_COLOR_MIXING_1 =						1301;	// Vector
enum WPREF_COLOR_MIXING_2 =						1302;	// Vector
enum WPREF_COLOR_MIXING_3 =						1303;	// Vector
enum WPREF_COLOR_MIXING_4 =						1304;	// Vector
enum WPREF_COLOR_SYSTEM_COLORCHOOSER =	1305;	// BOOL

enum WPREF_AUTOSAVE_ENABLE =					 1400;		// Bool
enum WPREF_AUTOSAVE_MIN =						 1401;		// Int32
enum WPREF_AUTOSAVE_LIMIT_TO =				 1402;		// Bool
enum WPREF_AUTOSAVE_LIMIT_NUM =			 1403;		// Int32
enum WPREF_AUTOSAVE_DEST =						 1405;		// Int32
enum WPREF_AUTOSAVE_DEST_BACKUPDIR =	 0;
enum WPREF_AUTOSAVE_DEST_USERDIR =		 1;
enum WPREF_AUTOSAVE_DEST_STARTUPDIR = 2;
enum WPREF_AUTOSAVE_DEST_PATH =			 1406;	// Filename
enum WPREF_COMMANDER_AT_CURSOR =			 1407;	// Bool

enum WPREF_PLUGINS =				 30006;					// Container
enum WPREF_CPUCOUNT =			 30010;					// Int32
enum WPREF_LOGFILE =				 30011;					// BOOL
enum WPREF_CONSOLEGI =			 30013;					// BOOL
enum WPREF_CPUCUSTOM =			 30014;					// BOOL
enum WPREF_RENDERQUEUELOG = 30015;					// BOOL

enum WPREF_BUBBLEHELP2 =								 21002;
enum WPREF_THREADPRIORITY =						 21003;
enum WPREF_MENUICON =									 21004;
enum WPREF_MENUSHORTCUT =							 21005;
enum WPREF_INACTIVEBORDER =						 21006;
enum WPREF_ACTIVEBORDER =							 21007;
enum WPREF_FONT_STANDARD =							 21050;
enum WPREF_FONT_MONO =									 21051;
enum WPREF_MAC_CTRLCLICK_EMULATES_RMB = 21062;
enum WPREF_MAC_MENUBAR =								 21063;
enum WPREF_UV_RELAX_DATA =							 21065;						// BaseContainer
enum WPREF_UV_OPTIMAL_MAPPING_DATA =		 21066;						// BaseContainer
enum WPREF_UV_PROJECTION_DATA =				 21067;						// BaseContainer
enum WPREF_UV_TAB_SEL =								 21068;						// BaseContainer
enum WPREF_UV_TRANSFORM_DATA =					 21069;						// BaseContainer
enum WPREF_LINUX_BROWSERPATH =					 21070;						// Filename
enum WPREF_MOUSEOVER_SHORTCUT =				 21072;						// Bool
enum WPREF_ONLINEHELP_PATH =						 21075;						// path
enum WPREF_ONLINEHELP_URL =						 21076;
enum WPREF_LINUX_IMAGEEDITPATH =				 21077;						// Filename
enum WPREF_LOCKINTERFACE =							 21078;						// Bool
enum WPREF_TOOLCURSOR_BASIC =					 21079;						// Bool
enum WPREF_TOOLCURSOR_ADV =						 21080;						// Bool

enum WPREF_ONLINEUPDATER_AUTO_CHECK =						 40000;	// bool
enum WPREF_ONLINEUPDATER_CHECKSUM =							 40001;	// private
enum WPREF_ONLINEUPDATER_SHOW_INSTALLED =				 40003;	// bool
enum WPREF_ONLINEUPDATER_AUTORESTART =						 40004;	// bool
enum WPREF_ONLINEUPDATER_BACKUP =								 40005;	// bool
enum WPREF_ONLINEUPDATER_BACKUP_PATH =						 40014;	// Filename
enum WPREF_ONLINEUPDATER_PROXYSERVER =						 40008;	// String
enum WPREF_ONLINEUPDATER_PROXYPORT =							 40009;	// Int32
enum WPREF_ONLINEUPDATER_LAST_OPEN_DAY =					 40011;	// Int32
enum WPREF_ONLINEUPDATER_LAST_OPEN_HOUR =				 40012;	// Float
enum WPREF_ONLINEUPDATER_REMOVE_FILES =					 40013;	// bool
enum WPREF_ONLINEUPDATER_SHOW_DEVELOPER_UPDATES = 40015;	// bool

enum WPREF_PV_RENDER_VIEW = 430000690;										// Int32 - the index id of the PictureViewer dialog that receives render output
enum WPREF_PV_RECENT =			 465001804;										//for recent files in PV

enum PVPREFSDIALOG_ID =		 465001700;
enum SCULPTPREFSDIALOG_ID = 1027830;

enum
{
	WPREFS_PVMEMORY = 1000,
	WPREFS_PVDRAWBUCKETS,
	WPREFS_PVHDMEM,
	WPREFS_PVHDFOLDER,
	WPREFS_PVHDUNLIMIT,
};

enum
{
	WPREFS_SCULPTMEMORY = 1000,
};

enum
{
	WPREF_NET_NAME = 1000,
	WPREF_NET_SHARE,
	WPREF_NET_THREADCUSTOM,
	WPREF_NET_RENDERTHREADS,
	WPREF_NET_SECURITYTOKEN,
	WPREF_NET_ALLOWRESTARTOFC4D,
	WPREF_NET_SERVER_PORTNUMBER,
	WPREF_NET_SERVER_REPOSITORYPATH,
	WPREF_NET_USEBONJOUR,
	WPREF_NET_USEENCRYPTION,
	WPREF_NET_HANDLEWARNINGASERROR,
	WPREF_NET_ABORTRENDERINGONCLIENTERROR,
	WPREF_NET_PEERTOPEERASSETDISTRIBUTION,
	WPREF_NET_REQUESTONDEMAND,
	WPREF_NET_EXCLUDECLIENTONRENDERINGERROR,
	WPREF_NET_RENDERINGTIMEOUT,
	WPREF_NET_ENABLETEAMRENDER,
	EX_WPREF_NET_WEBSERVERPORT,

	// stored in prefs but not visible
	WPREF_NET_SHOWBUCKETMACHINECOLOR,
	WPREF_NET_SHOWNAME,
	WPREF_NET_SHOWICON,
	WPREF_NET_SHOWINFO,
	WPREF_NET_SHOWCHECKBOX,
	WPREF_NET_SHOWADDRESS,
	WPREF_NET_MACHINEICONSIZE,
	// ------------------------------

	WPREF_NET_ENABLERENDERINGTIMEOUT
};

// mouse cursors
enum MOUSE_HIDE =							0;
enum MOUSE_SHOW =							1;
enum MOUSE_NORMAL =						2;
enum MOUSE_BUSY =							3;
enum MOUSE_CROSS =							4;
enum MOUSE_QUESTION =					5;
enum MOUSE_ZOOM_IN =						6;
enum MOUSE_ZOOM_OUT =					7;
enum MOUSE_FORBIDDEN =					8;
enum MOUSE_DELETE =						9;
enum MOUSE_COPY =							10;
enum MOUSE_INSERTCOPY =				11;
enum MOUSE_INSERTCOPYDOWN =		12;
enum MOUSE_MOVE =							13;
enum MOUSE_INSERTMOVE =				14;
enum MOUSE_INSERTMOVEDOWN =		15;
enum MOUSE_ARROW_H =						16;
enum MOUSE_ARROW_V =						17;
enum MOUSE_ARROW_HV =					18;
enum MOUSE_POINT_HAND =				19;
enum MOUSE_MOVE_HAND =					20;
enum MOUSE_IBEAM =							21;
enum MOUSE_SELECT_LIVE =				22;
enum MOUSE_SELECT_FREE =				23;
enum MOUSE_SELECT_RECT =				24;
enum MOUSE_SELECT_POLY =				25;
enum MOUSE_SPLINETOOLS =				26;
enum MOUSE_EXTRUDE =						27;
enum MOUSE_NORMALMOVE =				28;
enum MOUSE_ADDPOINTS =					29;
enum MOUSE_ADDPOLYGONS =				30;
enum MOUSE_BRIDGE =						31;
enum MOUSE_MIRROR =						32;
enum MOUSE_PAINTMOVE =					33;
enum MOUSE_PAINTSELECTRECT =		34;
enum MOUSE_PAINTSELECTCIRCLE =	35;
enum MOUSE_PAINTSELECTPOLY =		36;
enum MOUSE_PAINTSELECTFREE =		37;
enum MOUSE_PAINTMAGICWAND =		38;
enum MOUSE_PAINTCOLORRANGE =		39;
enum MOUSE_PAINTFILL =					40;
enum MOUSE_PAINTPICK =					41;
enum MOUSE_PAINTBRUSH =				42;
enum MOUSE_PAINTCLONE =				43;
enum MOUSE_PAINTTEXT =					44;
enum MOUSE_PAINTCROP =					45;
enum MOUSE_PAINTLINE =					46;
enum MOUSE_PAINTPOLYSHAPE =		47;

// global events
enum EVMSG_CHANGE =							 604;
enum EVMSG_DOCUMENTRECALCULATED			= C4D_FOUR_BYTE('d','r','c','l'); //? 'drcl';	// view has been animated, expression are executed, some manager data may have changed
//? enum EVMSG_TOOLCHANGED =				cast(Int32)(0xfff36465);	// Int32(0xfff36465); //compiler crash 
enum EVMSG_GRAPHVIEWCHANGED =		 400008000;
enum EVMSG_AUTKEYMODECHANGED =		 200000009;
enum EVMSG_UPDATEHIGHLIGHT =			 200000073;
enum EVMSG_CHANGEDSCRIPTMODE =		 1026569;

enum EVMSG_SHOWIN_SB =	 -200000074;
enum EVMSG_SHOWIN_TL =	 -200000075;
enum EVMSG_SHOWIN_FC =	 -200000076;
enum EVMSG_SHOWIN_LM =	 -200000077;
enum EVMSG_TLOM_MERGE = -465001000;

enum EVMSG_SHOWIN_MT = -200000078;

enum EVMSG_TIMELINESELECTION =	-1001;
enum EVMSG_BROWSERCHANGE =			-1002;
enum EVMSG_MATERIALSELECTION =	-1009;
enum EVMSG_FCURVECHANGE =			-1010;

enum EVMSG_RAYTRACER_FINISHED =		-1003;
enum EVMSG_MATERIALPREVIEW =				-1008;
enum EVMSG_ACTIVEVIEWCHANGED =			C4D_FOUR_BYTE('a','c','v','w');//'acvw';
enum EVMSG_ASYNCEDITORMOVE =			C4D_FOUR_BYTE('e','d','m','v');//'edmv';
enum MOVE_START =									0;
enum MOVE_CONTINUE =								1;
enum MOVE_END =										2;	// -> par2 == ESC
enum EVMSG_TIMECHANGED =				C4D_FOUR_BYTE('t','c','h','g');//'tchg';
enum EVMSG_VIEWWINDOW_OUTPUT =			-1011;
enum EVMSG_VIEWWINDOW_3DPAINTUPD =	-1012;
enum EVMSG_UPDATESCHEME =					200000010;
enum SCHEME_LIGHT =								0;
enum SCHEME_DARK =									1;
enum SCHEME_OTHER =								2;

enum EVENT
{
	EVENT_0								 = 0,
	EVENT_FORCEREDRAW			 = (1 << 0),
	EVENT_ANIMATE					 = (1 << 1),
	EVENT_NOEXPRESSION		 = (1 << 2),
	EVENT_GLHACK					 = (1 << 3),
	EVENT_CAMERAEXPRESSION = (1 << 4)
} mixin ENUM_END_FLAGS!(EVENT);

// draw flags
enum DRAWFLAGS
{
	DRAWFLAGS_0														= 0,
	DRAWFLAGS_NO_THREAD										= (1 << 1),
	DRAWFLAGS_NO_REDUCTION								= (1 << 2),
	DRAWFLAGS_NO_ANIMATION								= (1 << 8),
	DRAWFLAGS_ONLY_ACTIVE_VIEW						= (1 << 10),
	DRAWFLAGS_NO_EXPRESSIONS							= (1 << 12),
	DRAWFLAGS_INDRAG											= (1 << 13),
	DRAWFLAGS_NO_HIGHLIGHT_PLANE					= (1 << 14),
	DRAWFLAGS_FORCEFULLREDRAW							= (1 << 15),
	DRAWFLAGS_ONLY_CAMERAEXPRESSION				= (1 << 16),
	DRAWFLAGS_INMOVE											= (1 << 17),
	DRAWFLAGS_ONLY_BASEDRAW								= (1 << 22),	// draw specific BaseDraw only

	DRAWFLAGS_ONLY_HIGHLIGHT							= (1 << 18),
	DRAWFLAGS_STATICBREAK									= (1 << 19),	// only use in combination with DRAWFLAGS_NO_THREAD

	DRAWFLAGS_PRIVATE_NO_WAIT_GL_FINISHED	= (1 << 3),
	DRAWFLAGS_PRIVATE_ONLYBACKGROUND			= (1 << 4),
	DRAWFLAGS_PRIVATE_NOBLIT							= (1 << 9),
	DRAWFLAGS_PRIVATE_OPENGLHACK					= (1 << 11),
	DRAWFLAGS_PRIVATE_ONLY_PREPARE				= (1 << 21),
	DRAWFLAGS_PRIVATE_NO_3DCLIPPING				= (1 << 24)
} mixin ENUM_END_FLAGS!(DRAWFLAGS);

// animate scene/object flags
enum ANIMATEFLAGS
{
	ANIMATEFLAGS_0						= 0,
	ANIMATEFLAGS_NO_PARTICLES	= (1 << 2),
	ANIMATEFLAGS_NO_CHILDREN	= (1 << 6),
	ANIMATEFLAGS_INRENDER			= (1 << 7),
	ANIMATEFLAGS_NO_MINMAX		= (1 << 8),	// private
	ANIMATEFLAGS_NO_NLA				= (1 << 9),	// private
	ANIMATEFLAGS_NLA_SUM			= (1 << 10)	// private
} mixin ENUM_END_FLAGS!(ANIMATEFLAGS);

enum SAVEDOCUMENTFLAGS
{
	SAVEDOCUMENTFLAGS_0										= 0,
	SAVEDOCUMENTFLAGS_DIALOGSALLOWED			= (1 << 0),
	SAVEDOCUMENTFLAGS_SAVEAS							= (1 << 1),
	SAVEDOCUMENTFLAGS_DONTADDTORECENTLIST	= (1 << 2),
	SAVEDOCUMENTFLAGS_AUTOSAVE						= (1 << 3),
	SAVEDOCUMENTFLAGS_SAVECACHES					= (1 << 4),
	SAVEDOCUMENTFLAGS_EXPORTDIALOG				= (1 << 5),
	SAVEDOCUMENTFLAGS_CRASHSITUATION			= (1 << 6),
	SAVEDOCUMENTFLAGS_NO_SHADERCACHE			= (1 << 7)
} mixin ENUM_END_FLAGS!(SAVEDOCUMENTFLAGS);

enum COPYFLAGS
{
	COPYFLAGS_0																 = 0,
	COPYFLAGS_NO_HIERARCHY										 = (1 << 2),
	COPYFLAGS_NO_ANIMATION										 = (1 << 3),
	COPYFLAGS_NO_BITS													 = (1 << 4),
	COPYFLAGS_NO_MATERIALPREVIEW							 = (1 << 5),
	COPYFLAGS_NO_BRANCHES											 = (1 << 7),
	COPYFLAGS_DOCUMENT												 = (1 << 10),	// this flag is read-only, set when a complete document is copied
	COPYFLAGS_NO_NGONS												 = (1 << 11),
	COPYFLAGS_CACHE_BUILD											 = (1 << 13),	// this flags is read-only, set when a cache is built
	COPYFLAGS_RECURSIONCHECK									 = (1 << 14),

	COPYFLAGS_PRIVATE_IDENTMARKER							 = (1 << 0),	// private
	COPYFLAGS_PRIVATE_NO_INTERNALS						 = (1 << 8),	// private
	COPYFLAGS_PRIVATE_NO_PLUGINLAYER					 = (1 << 9),	// private
	COPYFLAGS_PRIVATE_UNDO										 = (1 << 12),	// private
	COPYFLAGS_PRIVATE_CONTAINER_COPY_DIRTY		 = (1 << 15),	// private
	COPYFLAGS_PRIVATE_CONTAINER_COPY_IDENTICAL = (1 << 16),	// private
	COPYFLAGS_PRIVATE_NO_TAGS									 = (1 << 17),	// private
	COPYFLAGS_PRIVATE_DELETE									 = (1 << 18),	// private
	COPYFLAGS_PRIVATE_BODYPAINT_NODATA				 = (1 << 29),	// private
	COPYFLAGS_PRIVATE_BODYPAINT_CONVERTLAYER	 = (1 << 30)	// private
} mixin ENUM_END_FLAGS!(COPYFLAGS);

enum UNDOTYPE
{
	UNDOTYPE_0													= 0,

	UNDOTYPE_CHANGE											= 40,	// complete with children
	UNDOTYPE_CHANGE_NOCHILDREN					= 41,	// complete without children
	UNDOTYPE_CHANGE_SMALL								= 42,	// object itself without branches
	UNDOTYPE_CHANGE_SELECTION						= 43,	// modeling point/polygon/edge selection

	UNDOTYPE_NEW												= 44,	// new object, call InitUndo after object is inserted
	UNDOTYPE_DELETE											= 45,	// delete object, call InitUndo before object is deleted

	UNDOTYPE_ACTIVATE										= 46,
	UNDOTYPE_DEACTIVATE									= 47,

	UNDOTYPE_BITS												= 48,
	UNDOTYPE_HIERARCHY_PSR							= 49,	// hierarchical placement and PSR values

	UNDOTYPE_PRIVATE_STRING							= 9996,
	UNDOTYPE_PRIVATE_MULTISELECTIONAXIS	= 9997,
	UNDOTYPE_START											= 9998,	// private
	UNDOTYPE_END												= 9999	// private
} mixin ENUM_END_LIST!(UNDOTYPE);

// handle types
enum DRAWHANDLE
{
	DRAWHANDLE_MINI					= 0,
	DRAWHANDLE_SMALL				= 1,
	DRAWHANDLE_MIDDLE				= 2,
	DRAWHANDLE_BIG					= 3,
	DRAWHANDLE_CUSTOM				= 4,
	DRAWHANDLE_POINTSIZE		= 5,
	DRAWHANDLE_SELPOINTSIZE	= 6
} mixin ENUM_END_LIST!(DRAWHANDLE);

enum DRAW_ALPHA
{
	DRAW_ALPHA_NONE							 = 10,
	DRAW_ALPHA_INVERTED					 = 11,
	DRAW_ALPHA_NORMAL						 = 12,	// generates alpha channel from the image's alpha channel. If no alpha channel exists, the alpha value is set to 100%
	DRAW_ALPHA_FROM_IMAGE				 = 13,	// generates the alpha channel from the RGB image information
	DRAW_ALPHA_NORMAL_FROM_IMAGE = 14		// generates alpha channel from the image's alpha channel. If no alpha channel exists, the alpha value is generated from the RGB imaged
} mixin ENUM_END_LIST!(DRAW_ALPHA);

enum DRAW_TEXTUREFLAGS
{
	DRAW_TEXTUREFLAGS_0	= 0x0,

	// flags for DrawTexture and SetTexture
	DRAW_TEXTUREFLAGS_COLOR_IMAGE_TO_LINEAR	= 0x00000001,	// convert from embedded profile to linear
	DRAW_TEXTUREFLAGS_COLOR_SRGB_TO_LINEAR	= 0x00000002,	// convert from SRGB to linear
	DRAW_TEXTUREFLAGS_COLOR_IMAGE_TO_SRGB		= 0x00000003,	// convert from embedded profile to SRGB
	DRAW_TEXTUREFLAGS_COLOR_LINEAR_TO_SRGB	= 0x00000004,	// convert from linear to SRGB
	DRAW_TEXTUREFLAGS_COLOR_CORRECTION_MASK	= 0x0000000f,	// color correction mask

	DRAW_TEXTUREFLAGS_USE_PROFILE_COLOR			= 0x00000010,
	DRAW_TEXTUREFLAGS_ALLOW_FLOATINGPOINT		= 0x00000020,	//  allow floating point textures (if supported)

	// interpolation flags
	DRAW_TEXTUREFLAGS_INTERPOLATION_NEAREST				= 0x00100000,
	DRAW_TEXTUREFLAGS_INTERPOLATION_LINEAR				= 0x00200000,
	DRAW_TEXTUREFLAGS_INTERPOLATION_LINEAR_MIPMAP	= 0x00400000,
	DRAW_TEXTUREFLAGS_INTERPOLATION_MASK					= 0x00f00000

} mixin ENUM_END_FLAGS!(DRAW_TEXTUREFLAGS);

enum TOOLDRAW
{
	TOOLDRAW_0					= 0,
	TOOLDRAW_HANDLES		= (1 << 0),
	TOOLDRAW_AXIS				= (1 << 1),
	TOOLDRAW_HIGHLIGHTS	= (1 << 2)
} mixin ENUM_END_FLAGS!(TOOLDRAW);

enum TOOLDRAWFLAGS
{
	TOOLDRAWFLAGS_0					= 0,
	TOOLDRAWFLAGS_INVERSE_Z	= (1 << 0),
	TOOLDRAWFLAGS_HIGHLIGHT	= (1 << 1)
} mixin ENUM_END_FLAGS!(TOOLDRAWFLAGS);

// viewport colors
enum VIEWCOLOR_C4DBACKGROUND =				0;
enum VIEWCOLOR_FILMFORMAT =					1;
enum VIEWCOLOR_HORIZON =							2;
enum VIEWCOLOR_GRID_MAJOR =					3;
enum VIEWCOLOR_GRID_MINOR =					4;
enum VIEWCOLOR_SPLINESTART =					5;
enum VIEWCOLOR_SPLINEEND =						6;
enum VIEWCOLOR_CAMERA =							7;
enum VIEWCOLOR_PARTICLE =						8;
enum VIEWCOLOR_PMODIFIER =						9;
enum DELME_VIEWCOLOR_BONE =					10;
enum VIEWCOLOR_MODIFIER =						11;
enum VIEWCOLOR_ACTIVEPOINT =					12;
enum VIEWCOLOR_INACTIVEPOINT =				13;
enum VIEWCOLOR_TANGENT =							14;
enum VIEWCOLOR_ACTIVEPOLYGON =				15;
enum VIEWCOLOR_INACTIVEPOLYGON =			16;
enum VIEWCOLOR_TEXTURE =							17;
enum VIEWCOLOR_TEXTUREAXIS =					18;
enum VIEWCOLOR_ACTIVEBOX =						19;
enum VIEWCOLOR_ANIMPATH =						20;
enum VIEWCOLOR_XAXIS =								21;
enum VIEWCOLOR_YAXIS =								22;
enum VIEWCOLOR_ZAXIS =								23;
enum VIEWCOLOR_WXAXIS =							24;
enum VIEWCOLOR_WYAXIS =							25;
enum VIEWCOLOR_WZAXIS =							26;
enum VIEWCOLOR_SELECT_AXIS =					27;
enum VIEWCOLOR_LAYER0 =							28;
enum VIEWCOLOR_LAYER1 =							29;
enum VIEWCOLOR_LAYER2 =							30;
enum VIEWCOLOR_LAYER3 =							31;
enum VIEWCOLOR_LAYER4 =							32;
enum VIEWCOLOR_LAYER5 =							33;
enum VIEWCOLOR_LAYER6 =							34;
enum VIEWCOLOR_LAYER7 =							35;
enum VIEWCOLOR_VERTEXSTART =					36;
enum VIEWCOLOR_VERTEXEND =						37;
enum VIEWCOLOR_UVMESH_GREYED =				38;
enum VIEWCOLOR_UVMESH_APOLY =				39;
enum VIEWCOLOR_UVMESH_IAPOLY =				40;
enum VIEWCOLOR_UVMESH_APOINT =				41;
enum VIEWCOLOR_UVMESH_IAPOINT =			42;
enum VIEWCOLOR_NORMAL =							43;
enum VIEWCOLOR_ACTIVECHILDBOX =			44;
enum VIEWCOLOR_ACTIVEPOLYBOX =				45;
enum VIEWCOLOR_ACTIVEPOLYCHILDBOX =	46;
enum VIEWCOLOR_SELECTION_PREVIEW =		47;
enum VIEWCOLOR_MEASURETOOL =					48;
//#define VIEWCOLOR_AXIS_BAND						49
enum VIEWCOLOR_SHADEDWIRE =					50;
enum VIEWCOLOR_NGONLINE =						51;
enum VIEWCOLOR_FRONTFACING =					52;
enum VIEWCOLOR_BACKFACING =					53;
enum VIEWCOLOR_MINSOFTSELECT =				54;
enum VIEWCOLOR_MAXSOFTSELECT =				55;
enum VIEWCOLOR_MINHNWEIGHT =					56;
enum VIEWCOLOR_ZEROHNWEIGHT =				57;
enum VIEWCOLOR_MAXHNWEIGHT =					58;
enum VIEWCOLOR_IRR =									59;
enum VIEWCOLOR_OBJECTHIGHLIGHT =			60;
enum VIEWCOLOR_OBJECTSELECT =				61;
enum VIEWCOLOR_C4DBACKGROUND_GRAD1 =	62;
enum VIEWCOLOR_C4DBACKGROUND_GRAD2 =	63;
enum VIEWCOLOR_BRUSHPREVIEW =				64;
enum VIEWCOLOR_SPLINEHULL =					65;
enum VIEWCOLOR_TOOLHANDLE =					66;
enum VIEWCOLOR_ACTIVETOOLHANDLE =		67;

enum VIEWCOLOR_MAXCOLORS =	68;

enum DIRTYFLAGS
{
	DIRTYFLAGS_0					 = 0,
	DIRTYFLAGS_MATRIX			 = (1 << 1),	// object matrix changed
	DIRTYFLAGS_DATA				 = (1 << 2),	// object internal data changed
	DIRTYFLAGS_SELECT			 = (1 << 3),	// object selections changed
	DIRTYFLAGS_CACHE			 = (1 << 4),	// object caches changed
	DIRTYFLAGS_CHILDREN		 = (1 << 5),
	DIRTYFLAGS_DESCRIPTION = (1 << 6),	// description changed

	// basedocument
	DIRTYFLAGS_SELECTION_OBJECTS	 = (1 << 20),
	DIRTYFLAGS_SELECTION_TAGS			 = (1 << 21),
	DIRTYFLAGS_SELECTION_MATERIALS = (1 << 22),

	DIRTYFLAGS_ALL								 = -1
} mixin ENUM_END_FLAGS!(DIRTYFLAGS);

enum HDIRTY_ID
{
	HDIRTY_ID_ANIMATION				= 0,
	HDIRTY_ID_OBJECT				= 1,
	HDIRTY_ID_OBJECT_MATRIX		    = 2,
	HDIRTY_ID_OBJECT_HIERARCHY      = 3,
	HDIRTY_ID_TAG					= 4,
	HDIRTY_ID_MATERIAL				= 5,
	HDIRTY_ID_SHADER				= 6,
	HDIRTY_ID_RENDERSETTINGS	    = 7,
	HDIRTY_ID_VP					= 8,
	HDIRTY_ID_FILTER				= 9,
	HDIRTY_ID_NBITS					= 10,
	HDIRTY_ID_MAX
} mixin ENUM_END_LIST!(HDIRTY_ID);

enum HDIRTYFLAGS
{
	HDIRTYFLAGS_0						= 0,
/*
	HDIRTYFLAGS_ANIMATION				= (1 << cast(UInt32)HDIRTY_ID_ANIMATION),
	HDIRTYFLAGS_OBJECT					= (1 << cast(UInt32)HDIRTY_ID_OBJECT),
	HDIRTYFLAGS_OBJECT_MATRIX			= (1 << cast(UInt32)HDIRTY_ID_OBJECT_MATRIX),
	HDIRTYFLAGS_OBJECT_HIERARCHY	    = (1 << cast(UInt32)HDIRTY_ID_OBJECT_HIERARCHY),
	HDIRTYFLAGS_TAG						= (1 << cast(UInt32)HDIRTY_ID_TAG),
	HDIRTYFLAGS_MATERIAL				= (1 << cast(UInt32)HDIRTY_ID_MATERIAL),
	HDIRTYFLAGS_SHADER					= (1 << cast(UInt32)HDIRTY_ID_SHADER),
	HDIRTYFLAGS_RENDERSETTINGS	        = (1 << cast(UInt32)HDIRTY_ID_RENDERSETTINGS),
	HDIRTYFLAGS_VP						= (1 << cast(UInt32)HDIRTY_ID_VP),
	HDIRTYFLAGS_FILTER					= (1 << cast(UInt32)HDIRTY_ID_FILTER),
	HDIRTYFLAGS_NBITS					= (1 << cast(UInt32)HDIRTY_ID_NBITS),
*/
	HDIRTYFLAGS_ALL						= -1
} mixin ENUM_END_FLAGS!(HDIRTYFLAGS);


enum ROTATIONORDER
{
	ROTATIONORDER_YXZGLOBAL	=	0,
	ROTATIONORDER_YZXGLOBAL	=	1,
	ROTATIONORDER_ZYXGLOBAL	=	2,
	ROTATIONORDER_ZXYGLOBAL	=	3,
	ROTATIONORDER_XZYGLOBAL	=	4,
	ROTATIONORDER_XYZGLOBAL	=	5,

	ROTATIONORDER_YXZLOCAL	= 3,
	ROTATIONORDER_YZXLOCAL	= 4,
	ROTATIONORDER_ZYXLOCAL	= 5,
	ROTATIONORDER_ZXYLOCAL	= 0,
	ROTATIONORDER_XZYLOCAL	= 1,
	ROTATIONORDER_XYZLOCAL	= 2,

	ROTATIONORDER_HPB				= 6,
	ROTATIONORDER_DEFAULT		= 6	// HPB is default
} mixin ENUM_END_LIST!(ROTATIONORDER);

enum BUILDFLAGS
{
	BUILDFLAGS_0								= 0,
	BUILDFLAGS_INTERNALRENDERER	= (1 << 1),
	BUILDFLAGS_EXTERNALRENDERER	= (1 << 2),
	BUILDFLAGS_ISOPARM					= (1 << 3)
} mixin ENUM_END_FLAGS!(BUILDFLAGS);

enum EXECUTIONFLAGS
{
	EXECUTIONFLAGS_0						 = 0,
	EXECUTIONFLAGS_ANIMATION		 = (1 << 1),
	EXECUTIONFLAGS_EXPRESSION		 = (1 << 2),
	EXECUTIONFLAGS_CACHEBUILDING = (1 << 3),
	EXECUTIONFLAGS_CAMERAONLY		 = (1 << 4),
	EXECUTIONFLAGS_INDRAG				 = (1 << 5),
	EXECUTIONFLAGS_INMOVE				 = (1 << 6),
	EXECUTIONFLAGS_RENDER				 = (1 << 7)
} mixin ENUM_END_FLAGS!(EXECUTIONFLAGS);

enum SCENEHOOKDRAW
{
	SCENEHOOKDRAW_0													 = 0,
	SCENEHOOKDRAW_DRAW_PASS									 = (1 << 0),
	SCENEHOOKDRAW_HIGHLIGHT_PASS_BEFORE_TOOL = (1 << 1),
	SCENEHOOKDRAW_HIGHLIGHT_PASS						 = (1 << 2),
	SCENEHOOKDRAW_HIGHLIGHT_PASS_INV				 = (1 << 3),
	SCENEHOOKDRAW_DRAW_PASS_AFTER_CLEAR			 = (1 << 4)
} mixin ENUM_END_FLAGS!(SCENEHOOKDRAW);

// flags for GetDescription
enum DESCFLAGS_DESC
{
	DESCFLAGS_DESC_0									 = 0,
	DESCFLAGS_DESC_RESOLVEMULTIPLEDATA = (1 << 0),
	DESCFLAGS_DESC_LOADED							 = (1 << 1),
	DESCFLAGS_DESC_RECURSIONLOCK			 = (1 << 2),
	DESCFLAGS_DESC_DONTLOADDEFAULT		 = (1 << 3),	// internal: used for old plugintools
	DESCFLAGS_DESC_MAPTAGS						 = (1 << 4),
	DESCFLAGS_DESC_NEEDDEFAULTVALUE		 = (1 << 5)		// DESC_DEFAULT needed
} mixin ENUM_END_FLAGS!(DESCFLAGS_DESC);

// flags for GetDParameter/SetDParameter
enum DESCFLAGS_GET
{
	DESCFLAGS_GET_0											= 0,
	DESCFLAGS_GET_PARAM_GET							= (1 << 1),
	DESCFLAGS_GET_NO_GLOBALDATA					= (1 << 4),
	DESCFLAGS_GET_NO_GEDATADEFAULTVALUE	= (1 << 5)
} mixin ENUM_END_FLAGS!(DESCFLAGS_GET);

enum DESCFLAGS_SET
{
	DESCFLAGS_SET_0											= 0,
	DESCFLAGS_SET_PARAM_SET							= (1 << 1),
	DESCFLAGS_SET_USERINTERACTION				= (1 << 2),
	DESCFLAGS_SET_DONTCHECKMINMAX				= (1 << 3),
	DESCFLAGS_SET_DONTAFFECTINHERITANCE	= (1 << 6),	// for render settings and post effects only (SetParameter)
	DESCFLAGS_SET_FORCESET							= (1 << 7)	// SetParameter: force the set value without GetParameter/Compare, use only for calls where you for sure changed the value!
} mixin ENUM_END_FLAGS!(DESCFLAGS_SET);

enum DESCFLAGS_ENABLE
{
	DESCFLAGS_ENABLE_0 = 0
} mixin ENUM_END_FLAGS!(DESCFLAGS_ENABLE);

enum HIERARCHYCLONEFLAGS
{
	HIERARCHYCLONEFLAGS_0				 = 0,
	HIERARCHYCLONEFLAGS_ASIS		 = (1 << 0),
	HIERARCHYCLONEFLAGS_ASPOLY	 = (1 << 1),
	HIERARCHYCLONEFLAGS_ASLINE	 = (1 << 2),
	HIERARCHYCLONEFLAGS_ASSPLINE = (1 << 3)
} mixin ENUM_END_FLAGS!(HIERARCHYCLONEFLAGS);

// error string dialog
enum CHECKVALUEFORMAT
{
	CHECKVALUEFORMAT_NOTHING = 0,
	CHECKVALUEFORMAT_DEGREE	 = 1,
	CHECKVALUEFORMAT_PERCENT = 2,
	CHECKVALUEFORMAT_METER	 = 3,
	CHECKVALUEFORMAT_INT		 = 5
} mixin ENUM_END_LIST!(CHECKVALUEFORMAT);

enum CHECKVALUERANGE
{
	CHECKVALUERANGE_GREATER					= 0,
	CHECKVALUERANGE_GREATEROREQUAL	= 1,
	CHECKVALUERANGE_LESS						= 2,
	CHECKVALUERANGE_LESSOREQUAL			= 3,
	CHECKVALUERANGE_BETWEEN					= 4,
	CHECKVALUERANGE_BETWEENOREQUAL	= 5,
	CHECKVALUERANGE_BETWEENOREQUALX	= 6,
	CHECKVALUERANGE_BETWEENOREQUALY	= 7,
	CHECKVALUERANGE_DIFFERENT				= 8
} mixin ENUM_END_LIST!(CHECKVALUERANGE);

// paintmesh bits
enum PAINTMESHFLAGS
{
	PAINTMESHFLAGS_0				= 0,

	PAINTMESHFLAGS_QUAD			= (1 << 1),		// polygon is quadrangle
	PAINTMESHFLAGS_SEL			= (1 << 6),		// polygon selected

	PAINTMESHFLAGS_SELA			= (1 << 2),		// point a selected
	PAINTMESHFLAGS_SELB			= (1 << 3),		// point b selected
	PAINTMESHFLAGS_SELC			= (1 << 4),		// point c selected
	PAINTMESHFLAGS_SELD			= (1 << 5),		// point d selected

	PAINTMESHFLAGS_TA				= (1 << 7),		// temporary selection for link mode
	PAINTMESHFLAGS_TB				= (1 << 8),		// temporary selection for link mode
	PAINTMESHFLAGS_TC				= (1 << 9),		// temporary selection for link mode
	PAINTMESHFLAGS_TD				= (1 << 10),	// temporary selection for link mode

	PAINTMESHFLAGS_INACTIVE = (1 << 11),	// no draw no change possible

	PAINTMESHFLAGS_EDGEA		= (1 << 12),	// edge a is ngonline
	PAINTMESHFLAGS_EDGEB		= (1 << 13),	// edge b is ngonline
	PAINTMESHFLAGS_EDGEC		= (1 << 14),	// edge c is ngonline
	PAINTMESHFLAGS_EDGED		= (1 << 15)		// edge d is ngonline
} mixin ENUM_END_FLAGS!(PAINTMESHFLAGS);

enum GETBRANCHINFO
{
	GETBRANCHINFO_0								 = 0,
	GETBRANCHINFO_ONLYWITHCHILDREN = (1 << 1),
	GETBRANCHINFO_GELISTNODES			 = (1 << 3),
	GETBRANCHINFO_ONLYMODIFIABLE	 = (1 << 4)
} mixin ENUM_END_FLAGS!(GETBRANCHINFO);

enum BRANCHINFOFLAGS
{
	BRANCHINFOFLAGS_0							 = 0,
	BRANCHINFOFLAGS_ANIMATE				 = (1 << 0),
	BRANCHINFOFLAGS_HIDEINTIMELINE = (1 << 4),
} mixin ENUM_END_FLAGS!(BRANCHINFOFLAGS);

enum GETACTIVEOBJECTFLAGS
{
	GETACTIVEOBJECTFLAGS_0							= 0,
	GETACTIVEOBJECTFLAGS_CHILDREN				= (1 << 0),
	GETACTIVEOBJECTFLAGS_SELECTIONORDER	= (1 << 1)
} mixin ENUM_END_FLAGS!(GETACTIVEOBJECTFLAGS);

enum DRAWPASS
{
	DRAWPASS_OBJECT			= 0,
	DRAWPASS_BOX				= 1,
	DRAWPASS_HANDLES		= 2,
	DRAWPASS_HIGHLIGHTS	= 3,
	DRAWPASS_XRAY				= 4
} mixin ENUM_END_LIST!(DRAWPASS);

// im-/export formats
enum FORMAT_PREF =	1000;
enum FORMAT_WAV =	1018;
enum FORMAT_L4D =	1020;
enum FORMAT_P4D =	1022;

enum FORMAT_C4DIMPORT =	 1001025;
enum FORMAT_C4DEXPORT =	 1001026;
enum FORMAT_XMLIMPORT =	 1001027;
enum FORMAT_XMLEXPORT =	 1001028;
enum FORMAT_C4D4IMPORT =	 1001029;
enum FORMAT_C4D5IMPORT =	 1001030;
enum FORMAT_VRML1IMPORT = 1001031;
enum FORMAT_VRML1EXPORT = 1001032;
enum FORMAT_VRML2IMPORT = 1001033;
enum FORMAT_VRML2EXPORT = 1001034;
enum FORMAT_DXFIMPORT =	 1001035;
enum FORMAT_DXFEXPORT =	 1001036;
enum FORMAT_3DSIMPORT =	 1001037;
enum FORMAT_3DSEXPORT =	 1001038;
enum FORMAT_OBJIMPORT =	 1001039;
enum FORMAT_OBJEXPORT =	 1001040;
enum FORMAT_Q3DIMPORT =	 1001041;
enum FORMAT_Q3DEXPORT =	 1001042;
enum FORMAT_LWSIMPORT =	 1001043;
enum FORMAT_LWOIMPORT =	 1001044;
enum FORMAT_AIIMPORT =		 1001045;
enum FORMAT_DEMIMPORT =	 1001046;
enum FORMAT_D3DEXPORT =	 1001047;

enum HIGHLIGHT_TRANSPARENCY = -140;

enum HERMITEFAK = 4.0;

enum CREATE_GL_HAS_ROOT = 1;
enum CREATE_GL_IS_ROOT =	 2;

enum DELETE_GL_HAS_ROOT = 1;
enum DELETE_GL_IS_ROOT =	 2;

enum SAVEPROJECT
{
	SAVEPROJECT_0													  = 0,
	SAVEPROJECT_ASSETS											= (1 << 1),	// Pass if the assets will be taken into account
	SAVEPROJECT_SCENEFILE										= (1 << 2),	// Pass if the scene will be taken into account
	SAVEPROJECT_DIALOGSALLOWED							= (1 << 3),	// Show dialogs like error messages, a file selection for missing assets or alerts if necessary
	SAVEPROJECT_SHOWMISSINGASSETDIALOG			= (1 << 4),	// If an asset is missing show a warning dialog - flag can be set without SAVEPROJECT_DIALOGSALLOWED
	SAVEPROJECT_ADDTORECENTLIST							= (1 << 5),	// Add document to the recent list
	SAVEPROJECT_DONTCOPYFILES								= (1 << 6),	// Does the same as without this flag but doesn't copy the files to the destination - used to simulate the function
	SAVEPROJECT_PROGRESSALLOWED							= (1 << 7),	// Show the progress bar in the main window
	SAVEPROJECT_DONTTOUCHDOCUMENT						= (1 << 8),	// Document will be in the same state as before the call was made
	SAVEPROJECT_DONTFAILONMISSINGASSETS			= (1 << 9),	// If this flag is passed, the function does not fail anymore when assets are missing.
	SAVEPROJECT_ISNET												= (1 << 10), // Private - is set only if the net module is collecting assets
	SAVEPROJECT_USEDOCUMENTNAMEASFILENAME		= (1 << 11)
} mixin ENUM_END_FLAGS!(SAVEPROJECT);

enum ICONDATAFLAGS
{
	ICONDATAFLAGS_0									= 0,
	ICONDATAFLAGS_APPLYCOLORPROFILE	= (1 << 0),
	ICONDATAFLAGS_DISABLED					= (1 << 1)
}
mixin ENUM_END_FLAGS!(ICONDATAFLAGS);

// userarea flags
enum USERAREAFLAGS
{
	USERAREA_0					 = (0),
	USERAREA_TABSTOP		 = (1 << 0),
	USERAREA_HANDLEFOCUS = (1 << 1),
	USERAREA_COREMESSAGE = (1 << 2),
	USERAREA_SYNCMESSAGE = (1 << 3),
	USERAREA_DONT_MIRROR = (1 << 30)
} mixin ENUM_END_FLAGS!(USERAREAFLAGS);

enum RESOURCEIMAGE_EMPTY_TRI_RIGHT =						 310002010;
enum RESOURCEIMAGE_RED_TRI_RIGHT =							 310002011;
enum RESOURCEIMAGE_EMPTY_RED_TRI_RIGHT =				 310002012;
enum RESOURCEIMAGE_YELLOW_DIAMOND =						 310002013;
enum RESOURCEIMAGE_YELLOW_TRI_RIGHT =					 310002014;
enum RESOURCEIMAGE_YELLOW_TRI_LEFT =						 310002015;
enum RESOURCEIMAGE_EMPTY_YELLOW_DIAMOND =			 310002016;
enum RESOURCEIMAGE_YELLOW_CIRCLE =							 310002017;
enum RESOURCEIMAGE_EMPTY_YELLOW_CIRCLE =				 310002018;
enum RESOURCEIMAGE_EMPTY_BLUE_CIRCLE =					 310002019;
enum RESOURCEIMAGE_BLUE_CIRCLE =								 310002020;
enum RESOURCEIMAGE_EMPTY_YELLOW_CIRCLE_LEFT =	 310002021;
enum RESOURCEIMAGE_EMPTY_YELLOW_CIRCLE_RIGHT =	 310002022;
enum RESOURCEIMAGE_EMPTY_TRI_LEFT =						 310002001;
enum RESOURCEIMAGE_RED_TRI_LEFT =							 310002002;
enum RESOURCEIMAGE_EMPTY_RED_TRI_LEFT =				 310002003;
enum RESOURCEIMAGE_EMPTY_DIAMOND =							 310002004;
enum RESOURCEIMAGE_RED_DIAMOND =								 310002005;
enum RESOURCEIMAGE_EMPTY_RED_DIAMOND =					 310002006;
enum RESOURCEIMAGE_EMPTY_CIRCLE =							 200000122;
enum RESOURCEIMAGE_RED_CIRCLE =								 300000121;
enum RESOURCEIMAGE_EMPTY_RED_CIRCLE =					 300000122;
enum RESOURCEIMAGE_KEYFRAME_BUTTON_UP =				 440000141;
enum RESOURCEIMAGE_KEYFRAME_BUTTON_OVER =			 440000142;
enum RESOURCEIMAGE_KEYFRAME_BUTTON_DOWN =			 440000143;
enum RESOURCEIMAGE_PIN =												 9000;
enum RESOURCEIMAGE_SUBGROUP =									 12678;
enum RESOURCEIMAGE_UNLOCKED =									 12679;
enum RESOURCEIMAGE_LOCKED =										 -12679;
enum RESOURCEIMAGE_HISTOGRAM =									 12680;
enum RESOURCEIMAGE_PLUS =											 300000118;
enum RESOURCEIMAGE_MINUS =											 300000119;
enum RESOURCEIMAGE_FOLDER =										 300000123;
enum RESOURCEIMAGE_OPENED =										 300000124;
enum RESOURCEIMAGE_CLOSED =										 300000125;
enum RESOURCEIMAGE_ARROWLEFT =									 300000126;
enum RESOURCEIMAGE_ARROWRIGHT =								 300000127;
enum RESOURCEIMAGE_ARROWUP =										 300000128;
enum RESOURCEIMAGE_AMDUPLICATE =								 300000129;
enum RESOURCEIMAGE_MOVE =											 13563;
enum RESOURCEIMAGE_SCALE =											 13564;
enum RESOURCEIMAGE_ROTATE =										 13565;
enum RESOURCEIMAGE_VIEWCHANGE =								 13640;
enum RESOURCEIMAGE_FULLSCREEN =								 17301;
enum RESOURCEIMAGE_CLOSERRELEASED =						 12097;
enum RESOURCEIMAGE_CLOSERPRESSED =							 -12097;
enum RESOURCEIMAGE_CANCEL =										 300000130;
enum RESOURCEIMAGE_OK =												 300000131;
enum RESOURCEIMAGE_OKCANCEL =									 300000132;
enum RESOURCEIMAGE_BOOLGROUP =									 300000133;
enum RESOURCEIMAGE_ADAPTERGROUP =							 300000134;
enum RESOURCEIMAGE_CALCULATEGROUP =						 300000135;
enum RESOURCEIMAGE_DEFAULTGROUP =							 300000136;
enum RESOURCEIMAGE_DEFAULTOPERATOR =						 300000137;
enum RESOURCEIMAGE_GENERALGROUP =							 300000138;
enum RESOURCEIMAGE_ITERATORGROUP =							 300000139;
enum RESOURCEIMAGE_LOGICALGROUP =							 300000140;
enum RESOURCEIMAGE_TPGROUP =										 300000141;
enum RESOURCEIMAGE_COFFEESCRIPT =							 300000142;
enum RESOURCEIMAGE_PYTHONSCRIPT =							 1022749;
enum RESOURCEIMAGE_UVWTAG_SECONDSTATE =				 300000143;
enum RESOURCEIMAGE_INSTANCEOBJECT_SECONDSTATE = 300000144;
enum RESOURCEIMAGE_LIGHT_SHADOWS =							 300000145;
enum RESOURCEIMAGE_LIGHT_SPOT =								 300000146;
enum RESOURCEIMAGE_LIGHT_SPOTSHADOWS =					 300000147;
enum RESOURCEIMAGE_LIGHT_PARALLEL =						 300000148;
enum RESOURCEIMAGE_LIGHT_PARALLELSHADOWS =			 300000149;
enum RESOURCEIMAGE_LIGHT_AREA =								 300000150;
enum RESOURCEIMAGE_LIGHT_AREASHADOWS =					 300000151;
enum RESOURCEIMAGE_BASEDRAW =									 300000152;
enum RESOURCEIMAGE_CTRACK =										 300000153;
enum RESOURCEIMAGE_BASEKEY =										 300000154;
enum RESOURCEIMAGE_BASESEQUENCE =							 300000155;
enum RESOURCEIMAGE_BASETRACK =									 300000156;
enum RESOURCEIMAGE_UNKNOWN =										 300000157;
enum RESOURCEIMAGE_BASESHADER =								 300000158;
enum RESOURCEIMAGE_PAINTBITMAP =								 300000159;
enum RESOURCEIMAGE_MULTIPLE =									 300000160;
enum RESOURCEIMAGE_EYEACTIVE =									 300000161;
enum RESOURCEIMAGE_EYEINACTIVE =								 300000162;
enum RESOURCEIMAGE_PENACTIVE =									 300000163;
enum RESOURCEIMAGE_PENINACTIVE =								 300000164;
enum RESOURCEIMAGE_ALPHAACTIVE =								 300000165;
enum RESOURCEIMAGE_ALPHAINACTIVE =							 300000166;
enum RESOURCEIMAGE_LINKEDACTIVE =							 300000167;
enum RESOURCEIMAGE_LINKEDINACTIVE =						 300000168;
enum RESOURCEIMAGE_BPAXIS =										 300000169;
enum RESOURCEIMAGE_BPCROSSED =									 300000170;
enum RESOURCEIMAGE_MOCCATREEVIEWNO =						 300000171;
enum RESOURCEIMAGE_MOCCATREEVIEWYES =					 300000172;
enum RESOURCEIMAGE_MOCCATREEVIEWLOCKED =				 300000173;
enum RESOURCEIMAGE_MOCCAIKTAG1 =								 300000174;
enum RESOURCEIMAGE_MOCCAIKTAG2 =								 300000175;
enum RESOURCEIMAGE_MOCCAIKTAG3 =								 300000176;
enum RESOURCEIMAGE_MOCCAIKTAG4 =								 300000177;
enum RESOURCEIMAGE_MOCCAIKTAG5 =								 300000178;
enum RESOURCEIMAGE_MOCCAIKTAG6 =								 300000185;
enum RESOURCEIMAGE_BITMAPFILTERPLUS =					 300000179;
enum RESOURCEIMAGE_BITMAPFILTERMINUS =					 300000180;
enum RESOURCEIMAGE_CLOTHING1 =									 300000181;
enum RESOURCEIMAGE_CLOTHING2 =									 300000182;
enum RESOURCEIMAGE_CLOTHING3 =									 300000183;
enum RESOURCEIMAGE_CLOTHING4 =									 300000184;
enum RESOURCEIMAGE_CLEARSELECTION =						 300000187;
enum RESOURCEIMAGE_GENERICCOMMAND =						 300000188;
enum RESOURCEIMAGE_TIMELINE_KEY1 =							 300000191;
enum RESOURCEIMAGE_TIMELINE_KEY2 =							 300000192;
enum RESOURCEIMAGE_AMMODELOCK_1 =							 300000193;
enum RESOURCEIMAGE_AMMODELOCK_2 =							 300000194;
enum RESOURCEIMAGE_SCENEBROWSER_HOME =					 300000195;
enum RESOURCEIMAGE_SCENEBROWSER_FILTER1 =			 300000196;
enum RESOURCEIMAGE_SCENEBROWSER_FILTER2 =			 300000197;
enum RESOURCEIMAGE_SCENEBROWSER_FIND1 =				 300000198;
enum RESOURCEIMAGE_SCENEBROWSER_FIND2 =				 300000199;
enum RESOURCEIMAGE_SCENEBROWSER_PATH1 =				 300000200;
enum RESOURCEIMAGE_SCENEBROWSER_PATH2 =				 300000201;
enum RESOURCEIMAGE_TIMELINE_STATE1 =						 300000202;
enum RESOURCEIMAGE_TIMELINE_STATE2 =						 300000203;
enum RESOURCEIMAGE_TIMELINE_STATE3 =						 300000204;
enum RESOURCEIMAGE_TIMELINE_STATE4 =						 300000205;
enum RESOURCEIMAGE_TIMELINE_STATE5 =						 300000206;
enum RESOURCEIMAGE_TIMELINE_STATE6 =						 300000207;
enum RESOURCEIMAGE_TIMELINE_KEYSTATE1 =				 300000208;
enum RESOURCEIMAGE_TIMELINE_KEYSTATE2 =				 300000209;
enum RESOURCEIMAGE_TIMELINE_KEYSTATE3 =				 300000210;
enum RESOURCEIMAGE_TIMELINE_KEYSTATE4 =				 300000211;
enum RESOURCEIMAGE_LAYERMANAGER_STATE1 =				 300000212;
enum RESOURCEIMAGE_LAYERMANAGER_STATE2 =				 300000213;
enum RESOURCEIMAGE_LAYERMANAGER_STATE3 =				 300000214;
enum RESOURCEIMAGE_LAYERMANAGER_STATE4 =				 300000215;
enum RESOURCEIMAGE_LAYERMANAGER_STATE5 =				 300000216;
enum RESOURCEIMAGE_LAYERMANAGER_STATE6 =				 300000217;
enum RESOURCEIMAGE_LAYERMANAGER_STATE7 =				 300000218;
enum RESOURCEIMAGE_LAYERMANAGER_STATE8 =				 300000219;
enum RESOURCEIMAGE_LAYERMANAGER_STATE9 =				 300000220;
enum RESOURCEIMAGE_LAYERMANAGER_STATE10 =			 300000221;
enum RESOURCEIMAGE_LAYERMANAGER_STATE11 =			 300000222;
enum RESOURCEIMAGE_LAYERMANAGER_STATE12 =			 300000223;
enum RESOURCEIMAGE_LAYERMANAGER_STATE13 =			 300000224;
enum RESOURCEIMAGE_LAYERMANAGER_STATE14 =			 300000225;
enum RESOURCEIMAGE_LAYERMANAGER_STATE15 =			 300000226;
enum RESOURCEIMAGE_LAYERMANAGER_STATE16 =			 300000227;
enum RESOURCEIMAGE_LAYERMANAGER_STATE17 =			 300000228;
enum RESOURCEIMAGE_LAYERMANAGER_STATE18 =			 300000229;
enum RESOURCEIMAGE_OBJECTMANAGER_STATE1 =			 300000230;
enum RESOURCEIMAGE_OBJECTMANAGER_STATE2 =			 300000231;
enum RESOURCEIMAGE_OBJECTMANAGER_STATE3 =			 300000232;
enum RESOURCEIMAGE_OBJECTMANAGER_STATE4 =			 300000233;
enum RESOURCEIMAGE_OBJECTMANAGER_DOT1 =				 300000234;
enum RESOURCEIMAGE_OBJECTMANAGER_DOT2 =				 300000235;
enum RESOURCEIMAGE_OBJECTMANAGER_DOT3 =				 300000236;
enum RESOURCEIMAGE_OBJECTMANAGER_DOT4 =				 300000237;
enum RESOURCEIMAGE_OBJECTMANAGER_LOCK =				 300000238;
enum RESOURCEIMAGE_TIMELINE_FOLDER1 =					 300000239;
enum RESOURCEIMAGE_TIMELINE_FOLDER2 =					 300000240;
enum RESOURCEIMAGE_TIMELINE_FOLDER3 =					 300000241;
enum RESOURCEIMAGE_TIMELINE_FOLDER4 =					 300000242;
enum RESOURCEIMAGE_TIMELINE_ROOT1 =						 300000243;
enum RESOURCEIMAGE_TIMELINE_ROOT2 =						 300000244;
enum RESOURCEIMAGE_TIMELINE_ROOT3 =						 300000245;
enum RESOURCEIMAGE_OBJECTMANAGER_DISP1 =				 300000246;
enum RESOURCEIMAGE_OBJECTMANAGER_DISP2 =				 300000247;
enum RESOURCEIMAGE_OBJECTMANAGER_DISP3 =				 300000248;
enum RESOURCEIMAGE_OBJECTMANAGER_DISP4 =				 300000249;
enum RESOURCEIMAGE_BROWSER_DESKTOP =						 300000251;
enum RESOURCEIMAGE_BROWSER_HOME =							 300000252;
enum RESOURCEIMAGE_BROWSER_PRESET =						 300000253;
enum RESOURCEIMAGE_BROWSER_CATALOG =						 300000254;
enum RESOURCEIMAGE_BROWSER_SEARCH =						 300000255;
enum RESOURCEIMAGE_BROWSER_PLAY =							 300000256;
enum RESOURCEIMAGE_BROWSER_PAUSE =							 300000257;
enum RESOURCEIMAGE_BROWSER_SMALLVIEW =					 300000258;
enum RESOURCEIMAGE_BROWSER_BIGVIEW =						 300000259;
enum RESOURCEIMAGE_ONLINEHELP_HOME =						 300000260;
enum RESOURCEIMAGE_ARROWDOWN =									 300000263;
enum RESOURCEIMAGE_EYETRISTATE =								 300000264;
enum RESOURCEIMAGE_PREVIOUSPAGE =							 1022433;
enum RESOURCEIMAGE_FOLLOWINGPAGE =							 1022434;
enum RESOURCEIMAGE_LIGHT_PHOTOMETRIC =					 300000265;
enum RESOURCEIMAGE_LIGHT_PHOTOMETRICSHADOWS =	 300000266;
enum RESOURCEIMAGE_MENU_OPTIONS =							 200000283;
enum RESOURCEIMAGE_PICKSESSION =								 200000270;
enum RESOURCEIMAGE_PICKSESSION2 =							 200000271;
enum HOTKEY_RESIZE_BRUSH =											 440000144;
enum RESOURCEIMAGE_LAYERMANAGER_STATE19 =			 1028287;
enum RESOURCEIMAGE_LAYERMANAGER_STATE20 =			 1028288;

//static if(!__API_INTERN__) {

enum HOTKEY_CAMERA_MOVE =	 13563;
enum HOTKEY_CAMERA_SCALE =	 13564;
enum HOTKEY_CAMERA_ROTATE = 13565;

enum HOTKEY_OBJECT_MOVE =	 13566;
enum HOTKEY_OBJECT_SCALE =	 13567;
enum HOTKEY_OBJECT_ROTATE = 13568;

enum HOTKEY_MODEL_SCALE = 13569;
enum HOTKEY_ZOOM =				 13570;
enum HOTKEY_SELECT_FREE = 13571;
enum HOTKEY_SELECT_LIVE = 13572;
enum HOTKEY_SELECT_RECT = 13573;

enum HOTKEY_PARENT_MOVE = 440000088;

enum IDM_UNDO =			 12105;
enum IDM_REDO =			 12297;
enum IDM_CUT =				 12106;
enum IDM_COPY =			 12107;
enum IDM_PASTE =			 12108;
enum IDM_DELETE =		 12109;
enum IDM_SELECTALL =	 12112;
enum IDM_SELECTNONE = 12113;
enum IDM_INVERSION =	 12374;
enum IDM_KEY_LAST =	 12415;
enum IDM_KEY_NEXT =	 12416;

//} //static if(!__API_INTERN__)

// predefined calling points for tags and scene hooks
enum EXECUTIONPRIORITY_INITIAL =				1000;
enum EXECUTIONPRIORITY_ANIMATION =			2000;
enum EXECUTIONPRIORITY_ANIMATION_NLA =	2010;
enum EXECUTIONPRIORITY_EXPRESSION =		3000;
enum EXECUTIONPRIORITY_DYNAMICS =			4000;
enum EXECUTIONPRIORITY_GENERATOR =			5000;

enum EXECUTIONRESULT
{
	EXECUTIONRESULT_OK					= 0,
	EXECUTIONRESULT_USERBREAK		= 1,
	EXECUTIONRESULT_OUTOFMEMORY	= 2
} mixin ENUM_END_LIST!(EXECUTIONRESULT);

enum
{
	DLG_OK		 = 1,
	DLG_CANCEL = 2
};

enum IMAGERESULT
{
	IMAGERESULT_OK						=  1,
	IMAGERESULT_NOTEXISTING		= -1,
	IMAGERESULT_WRONGTYPE			= -2,
	IMAGERESULT_OUTOFMEMORY		= -3,
	IMAGERESULT_FILEERROR			= -4,
	IMAGERESULT_FILESTRUCTURE	= -5,
	IMAGERESULT_MISC_ERROR		= -6,
	IMAGERESULT_PARAM_ERROR		= -7
} mixin ENUM_END_LIST!(IMAGERESULT);

enum STRINGENCODING
{
	STRINGENCODING_XBIT		 = 0,
	STRINGENCODING_8BIT		 = 1,
	STRINGENCODING_7BIT		 = 2,
	STRINGENCODING_7BITHEX = 3,
	STRINGENCODING_UTF8		 = 4,
	STRINGENCODING_HTML		 = 5
} mixin ENUM_END_LIST!(STRINGENCODING);

enum THREADMODE
{
	THREADMODE_SYNCHRONOUS = 0,
	THREADMODE_ASYNC			 = 1
} mixin ENUM_END_LIST!(THREADMODE);

enum THREADPRIORITY
{
	THREADPRIORITY_NORMAL	= 0,
	THREADPRIORITY_ABOVE	= 1000,
	THREADPRIORITY_BELOW	= 1001,
	THREADPRIORITY_LOWEST	= 1002
} mixin ENUM_END_LIST!(THREADPRIORITY);

enum HYPERFILEARRAY
{
	HYPERFILEARRAY_CHAR	 = 1,
	HYPERFILEARRAY_WORD	 = 2,
	HYPERFILEARRAY_LONG	 = 3,
	HYPERFILEARRAY_LLONG = 4,
	HYPERFILEARRAY_SREAL = 5,
	HYPERFILEARRAY_LREAL = 6,
	HYPERFILEARRAY_REAL	 = 7
} mixin ENUM_END_LIST!(HYPERFILEARRAY);

enum FILEERROR
{
	FILEERROR_NONE				=  0,	// no error
	FILEERROR_OPEN				= -1,	// problems opening the file
	FILEERROR_CLOSE				= -2,	// problems closing the file
	FILEERROR_READ				= -3,	// problems reading the file
	FILEERROR_WRITE				= -4,	// problems writing the file
	FILEERROR_SEEK				= -5,	// problems seeking the file
	FILEERROR_INVALID			= -6,	// invalid parameter or operation (e.g. writing in read-mode)
	FILEERROR_OUTOFMEMORY	= -7,	// not enough memory
	FILEERROR_USERBREAK		= -8,	// user break

	// the following values can only occur in HyperFiles
	FILEERROR_WRONG_VALUE		 = -100,	// other value detected than expected
	FILEERROR_CHUNK_NUMBER	 = -102,	// wrong number of chunks or sub chunks detected
	FILEERROR_VALUE_NO_CHUNK = -103,	// there was a value without any enclosing START/STOP chunks
	FILEERROR_FILE_END			 = -104,	// the file end was reached without finishing reading
	FILEERROR_UNKNOWN_VALUE	 = -105		// unknown value detected
} mixin ENUM_END_LIST!(FILEERROR);

enum FILEOPEN
{
	FILEOPEN_APPEND				= 0,
	FILEOPEN_READ					= 1,
	FILEOPEN_WRITE				= 2,
	FILEOPEN_READWRITE		= 3,
	FILEOPEN_READ_NOCACHE	= 4,
	FILEOPEN_SHAREDREAD		= 5,
	FILEOPEN_SHAREDWRITE	= 6
} mixin ENUM_END_LIST!(FILEOPEN);

enum LOCATION
{
	LOCATION_DISK					= 1,	// real storage
	LOCATION_IPCONNECTION = 2,	// target is ip connection
	LOCATION_MEMORY				= 3		// target is a memory location
} mixin ENUM_END_LIST!(LOCATION);

enum FILESEEK
{
	FILESEEK_START		= 0,
	FILESEEK_RELATIVE	= 2
} mixin ENUM_END_LIST!(FILESEEK);

enum FILEDIALOG
{
	FILEDIALOG_NONE				= 0,
	FILEDIALOG_ANY				= 1,
	FILEDIALOG_IGNOREOPEN	= 2
} mixin ENUM_END_LIST!(FILEDIALOG);

enum FILESELECT
{
	FILESELECT_LOAD			 = 0,
	FILESELECT_SAVE			 = 1,
	FILESELECT_DIRECTORY = 2
} mixin ENUM_END_LIST!(FILESELECT);

enum FILESELECTTYPE
{
	FILESELECTTYPE_ANYTHING	 = 0,
	FILESELECTTYPE_IMAGES		 = 1,
	FILESELECTTYPE_SCENES		 = 2,
	FILESELECTTYPE_COFFEE		 = 3,
	FILESELECTTYPE_BODYPAINT = 4
} mixin ENUM_END_LIST!(FILESELECTTYPE);

enum OPERATINGSYSTEM
{
	OPERATINGSYSTEM_WIN	 = 1,
	OPERATINGSYSTEM_OSX	 = 2,
	OPERATINGSYSTEM_UNIX = 3
} mixin ENUM_END_LIST!(OPERATINGSYSTEM);

enum BYTEORDER
{
	BYTEORDER_MOTOROLA = 1,
	BYTEORDER_INTEL		 = 2
} mixin ENUM_END_LIST!(BYTEORDER);

enum HYPERFILEVALUE
{
	HYPERFILEVALUE_NONE							 =  0,

	HYPERFILEVALUE_START						 =  1,
	HYPERFILEVALUE_STOP							 =  2,
	HYPERFILEVALUE_CSTOP						 =  3,
	HYPERFILEVALUE_CHAR							 = 11,
	HYPERFILEVALUE_UCHAR						 = 12,
	HYPERFILEVALUE_INT16						 = 13,
	HYPERFILEVALUE_UINT16						 = 14,
	HYPERFILEVALUE_INT32						 = 15,
	HYPERFILEVALUE_UINT32						 = 16,
	HYPERFILEVALUE_INT64						 = 17,
	HYPERFILEVALUE_UINT64						 = 18,
	HYPERFILEVALUE_FLOAT						 = 19,
	HYPERFILEVALUE_FLOAT64					 = 20,
	HYPERFILEVALUE_BOOL							 = 21,
	HYPERFILEVALUE_TIME							 = 22,
	HYPERFILEVALUE_VECTOR						 = 23,
	HYPERFILEVALUE_VECTOR64					 = 24,
	HYPERFILEVALUE_MATRIX						 = 25,
	HYPERFILEVALUE_MATRIX64					 = 26,
	HYPERFILEVALUE_VECTOR32					 = 27,
	HYPERFILEVALUE_MATRIX32					 = 28,
	HYPERFILEVALUE_FLOAT32					 = 29,

	HYPERFILEVALUE_MEMORY						 = 128,
	HYPERFILEVALUE_IMAGE						 = 129,
	HYPERFILEVALUE_STRING						 = 130,
	HYPERFILEVALUE_FILENAME					 = 131,
	HYPERFILEVALUE_CONTAINER				 = 132,
	HYPERFILEVALUE_ALIASLINK				 = 138,
	HYPERFILEVALUE_LMEMORY					 = 139,
	HYPERFILEVALUE_VECTOR_ARRAY_EX	 = 133,
	HYPERFILEVALUE_POLYGON_ARRAY_EX	 = 134,
	HYPERFILEVALUE_UINT16_ARRAY_EX	 = 135,
	HYPERFILEVALUE_PARTICLE_ARRAY_EX = 136,
	HYPERFILEVALUE_SREAL_ARRAY_EX		 = 137,
	HYPERFILEVALUE_ARRAY						 = 140,
	HYPERFILEVALUE_UUID							 = 141
} mixin ENUM_END_LIST!(HYPERFILEVALUE);

enum FINDANIM
{
	FINDANIM_EXACT = 0,
	FINDANIM_LEFT	 = 1,
	FINDANIM_RIGHT = 2
} mixin ENUM_END_LIST!(FINDANIM);

enum CCURVE
{
	CCURVE_CURVE		 = 1,
	CCURVE_HLE_BASE	 = 2,
	CCURVE_HLE_CURVE = 3,
	CCURVE_SS_CURVE	 = 4,

	// multiple Snapshots
	CCURVE_SS_CURVE2 = 5,
	CCURVE_SS_CURVE3 = 6,
	CCURVE_SS_CURVE4 = 7,
	CCURVE_SS_CURVE5 = 8,

	// Scale and Move HLE Curve
	CCURVE_HLE_SCALE = 9,
	CCURVE_HLE_MOVE	 = 10
} mixin ENUM_END_LIST!(CCURVE);

enum CLOOP
{
	CLOOP_OFF					 = 0,
	CLOOP_CONSTANT		 = 1,
	CLOOP_CONTINUE		 = 2,
	CLOOP_REPEAT			 = 3,
	CLOOP_OFFSETREPEAT = 4,
	CLOOP_OSCILLATE		 = 5
} mixin ENUM_END_LIST!(CLOOP);

enum CINTERPOLATION
{
	CINTERPOLATION_SPLINE = 1,
	CINTERPOLATION_LINEAR = 2,
	CINTERPOLATION_STEP		= 3,

	CINTERPOLATION_DUMMY	= 4
} mixin ENUM_END_LIST!(CINTERPOLATION);

enum CLIPBOARDTYPE
{
	CLIPBOARDTYPE_EMPTY	 =0,
	CLIPBOARDTYPE_STRING =1,
	CLIPBOARDTYPE_BITMAP =2
} mixin ENUM_END_LIST!(CLIPBOARDTYPE);

enum EDGESELECTIONTYPE
{
	EDGESELECTIONTYPE_SELECTION = 0,
	EDGESELECTIONTYPE_HIDDEN		= 1,
	EDGESELECTIONTYPE_PHONG			= 2
} mixin ENUM_END_LIST!(EDGESELECTIONTYPE);

enum REGISTRYTYPE
{
	REGISTRYTYPE_ANY							=  0,
	REGISTRYTYPE_WINDOW						=  1,
	REGISTRYTYPE_OBJECT						=  2,
	REGISTRYTYPE_TRACK_EX					=  3,
	REGISTRYTYPE_SEQUENCE_EX			=  4,
	REGISTRYTYPE_KEY_EX						=  5,
	REGISTRYTYPE_TAG							=  6,
	REGISTRYTYPE_MATERIAL					=  7,
	REGISTRYTYPE_SHADER						=  8,
	REGISTRYTYPE_COFFEE_EXT				=  9,
	REGISTRYTYPE_SOUND						=	10,
	REGISTRYTYPE_LAYOUT						=	11,
	REGISTRYTYPE_BITMAPFILTER			=	12,
	REGISTRYTYPE_VIDEOPOST				=	13,
	REGISTRYTYPE_SCENEHOOK				=	14,
	REGISTRYTYPE_NODE							=	15,
	REGISTRYTYPE_DESCRIPTION			=	16,
	REGISTRYTYPE_LIBRARY					=	17,
	REGISTRYTYPE_CUSTOMDATATYPE		=	18,
	REGISTRYTYPE_RESOURCEDATATYPE	=	19,
	REGISTRYTYPE_SCENELOADER			=	20,
	REGISTRYTYPE_SCENESAVER				=	21,
	REGISTRYTYPE_SNHOOK						=	22,
	REGISTRYTYPE_CTRACK						= 23,
	REGISTRYTYPE_CSEQ							= 24,
	REGISTRYTYPE_CKEY							= 25,
	REGISTRYTYPE_PAINTER					=	26,
	REGISTRYTYPE_GV_VALUE					= 27,
	REGISTRYTYPE_GV_VALGROUP			= 28,
	REGISTRYTYPE_GV_OPGROUP				= 29,
	REGISTRYTYPE_GV_OPCLASS				= 30,
	REGISTRYTYPE_GV_DATA					= 31,
	REGISTRYTYPE_GADGETS					= 32,
	REGISTRYTYPE_PREFS						= 33
} mixin ENUM_END_LIST!(REGISTRYTYPE);

enum MODELINGCOMMANDMODE
{
	MODELINGCOMMANDMODE_ALL							 = 0,
	MODELINGCOMMANDMODE_POINTSELECTION	 = 1,
	MODELINGCOMMANDMODE_POLYGONSELECTION = 2,
	MODELINGCOMMANDMODE_EDGESELECTION		 = 3
} mixin ENUM_END_LIST!(MODELINGCOMMANDMODE);

enum MODELINGCOMMANDFLAGS
{
	MODELINGCOMMANDFLAGS_0					= 0,
	MODELINGCOMMANDFLAGS_CREATEUNDO	= (1 << 0)
} mixin ENUM_END_FLAGS!(MODELINGCOMMANDFLAGS);

enum PLUGINTYPE
{
	PLUGINTYPE_ANY								=  0,

	PLUGINTYPE_SHADER							=  1,
	PLUGINTYPE_MATERIAL						=  2,
	PLUGINTYPE_COFFEEMESSAGE			=  3,
	PLUGINTYPE_COMMAND						=  4,
	PLUGINTYPE_OBJECT							=  5,
	PLUGINTYPE_TAG								=  6,
	PLUGINTYPE_BITMAPFILTER				=  7,
	PLUGINTYPE_VIDEOPOST					=  8,
	PLUGINTYPE_TOOL								=  9,
	PLUGINTYPE_SCENEHOOK					= 10,
	PLUGINTYPE_NODE								= 11,
	PLUGINTYPE_LIBRARY						= 12,
	PLUGINTYPE_BITMAPLOADER				= 13,
	PLUGINTYPE_BITMAPSAVER				= 14,
	PLUGINTYPE_SCENELOADER				= 15,
	PLUGINTYPE_SCENESAVER					= 16,
	PLUGINTYPE_COREMESSAGE				= 17,
	PLUGINTYPE_CUSTOMGUI					= 18,
	PLUGINTYPE_CUSTOMDATATYPE			= 19,
	PLUGINTYPE_RESOURCEDATATYPE		= 20,
	PLUGINTYPE_MANAGERINFORMATION	= 21,
	PLUGINTYPE_CTRACK							= 32,
	PLUGINTYPE_FALLOFF						= 33,
	PLUGINTYPE_VMAPTRANSFER				= 34,
	PLUGINTYPE_PREFS							= 35,
	PLUGINTYPE_SNAP								= 36
} mixin ENUM_END_LIST!(PLUGINTYPE);

enum DRAWRESULT
{
	DRAWRESULT_ERROR = 0,
	DRAWRESULT_OK		 = 1,
	DRAWRESULT_SKIP	 = 2
} mixin ENUM_END_LIST!(DRAWRESULT);

enum DISPLAYMODE
{
	DISPLAYMODE_UNKNOWN					= -1,
	DISPLAYMODE_GOURAUD					= 0,
	DISPLAYMODE_QUICK						= 1,
	DISPLAYMODE_WIRE						= 2,
	DISPLAYMODE_ISOPARM					= 3,
	DISPLAYMODE_SHADEDBOX				= 4,
	DISPLAYMODE_BOX							= 5,
	DISPLAYMODE_SKELETON				= 6,
	DISPLAYMODE_GOURAUDWIRE			= 7,
	DISPLAYMODE_GOURAUDISOPARM	= 8,
	DISPLAYMODE_QUICKWIRE				= 9,
	DISPLAYMODE_QUICKISOPARM		= 10,
	DISPLAYMODE_FLATWIRE				= 11,
	DISPLAYMODE_FLATISOPARM			= 12,
	DISPLAYMODE_FLATBOX					= 13,
	DISPLAYMODE_HIDDENWIRE			= 14,
	DISPLAYMODE_HIDDENISOPARM		= 15,
	DISPLAYMODE_HIDDENBOX				= 16,
	DISPLAYMODE_SHADEDBOXWIRE		= 17,
	DISPLAYMODE_QUICKBOXWIRE		= 18,
	DISPLAYMODE_QUICKBOX				= 19,

	DISPLAYMODE_PRIVATE_ISOLINE	= 100,
	DISPLAYMODE_PRIVATE_FLAT		= 1100,
	DISPLAYMODE_PRIVATE_HIDDEN	= 1400
} mixin ENUM_END_LIST!(DISPLAYMODE);

enum DOCUMENTSETTINGS
{
	DOCUMENTSETTINGS_GENERAL				 = 0,
	DOCUMENTSETTINGS_MODELING				 = 1,
	DOCUMENTSETTINGS_DOCUMENT				 = 2,
	DOCUMENTSETTINGS_ANIMATIONSYSTEM = 7,
	DOCUMENTSETTINGS_TOOLS					 = 8
} mixin ENUM_END_LIST!(DOCUMENTSETTINGS);

enum SERIALINFO
{
	SERIALINFO_CINEMA4D			= 0,
	SERIALINFO_MULTILICENSE	= 2
} mixin ENUM_END_LIST!(SERIALINFO);

enum VERSIONTYPE
{
	VERSIONTYPE_PRIME								 = 0,
	VERSIONTYPE_BODYPAINT						 = 1,
	VERSIONTYPE_STUDIO							 = 2,
	VERSIONTYPE_VISUALIZE						 = 3,
	VERSIONTYPE_BROADCAST						 = 4,
	VERSIONTYPE_BENCHMARK						 = 5,
	VERSIONTYPE_UPDATER							 = 6,
	VERSIONTYPE_INSTALLER						 = 7,
	VERSIONTYPE_NET_CLIENT					 = 8,
	VERSIONTYPE_NET_SERVER_3				 = 9,
	VERSIONTYPE_NET_SERVER_UNLIMITED = 10,
	VERSIONTYPE_UNKNOWN							 = 11,	// unknown
	VERSIONTYPE_LICENSESERVER				 = 12
} mixin ENUM_END_LIST!(VERSIONTYPE);

enum LAYERSETMODE
{
	LAYERSETMODE_LAYERS,
	LAYERSETMODE_LAYERMASKS,
	LAYERSETMODE_ALPHAS,
	LAYERSETMODE_LAYERALPHA,
	LAYERSETMODE_DISABLED
} mixin ENUM_END_LIST!(LAYERSETMODE);

enum SYSTEMINFO
{
	SYSTEMINFO_0									= 0,
	SYSTEMINFO_COMMANDLINE				= (1 << 1),	// application runs in command line mode
	SYSTEMINFO_DEMO								= (1 << 2),	// (deprecated)
	SYSTEMINFO_SAVABLEDEMO				= (1 << 3),	// savable demo
	SYSTEMINFO_SAVABLEDEMO_ACTIVE	= (1 << 4),	// activated savable demo, SYSTEMINFO_SAVABLEDEMO is still set
	SYSTEMINFO_OPENGL							= (1 << 5),	// OpenGL is activated and loaded correctly
	SYSTEMINFO_STUDENT						= (1 << 6),	// activated student version, this is always set along with SYSTEMINFO_SAVABLEDEMO
	SYSTEMINFO_LITE								= (1 << 7),	// light version, cannot load any plugins
	SYSTEMINFO_LITE_ACTIVE				= (1 << 8)	// light version is registered
} mixin ENUM_END_FLAGS!(SYSTEMINFO);

enum ID_MT_SOURCECOUNTER =	465001520;	//Int32

// maximum number of texture paths
enum MAX_GLOBAL_TEXTURE_PATHS = 10;

enum SELECTIONFILTERBIT
{
	SELECTIONFILTERBIT_0					= 0,
	SELECTIONFILTERBIT_NULL				= (1 << 0),
	SELECTIONFILTERBIT_POLYGON		= (1 << 1),
	SELECTIONFILTERBIT_SPLINE			= (1 << 2),
	SELECTIONFILTERBIT_GENERATOR	= (1 << 3),
	SELECTIONFILTERBIT_HYPERNURBS = (1 << 4),
	SELECTIONFILTERBIT_DEFORMER		= (1 << 6),
	SELECTIONFILTERBIT_CAMERA			= (1 << 7),
	SELECTIONFILTERBIT_LIGHT			= (1 << 8),
	SELECTIONFILTERBIT_SCENE			= (1 << 9),
	SELECTIONFILTERBIT_PARTICLE		= (1 << 10),
	SELECTIONFILTERBIT_OTHER			= (1 << 11),
	SELECTIONFILTERBIT_JOINT			= (1 << 25)
} mixin ENUM_END_FLAGS!(SELECTIONFILTERBIT);

enum OBJECTSTATE
{
	OBJECTSTATE_EDITOR = 0,
	OBJECTSTATE_RENDER = 1,
	OBJECTSTATE_DEFORM = 2
} mixin ENUM_END_LIST!(OBJECTSTATE);

// display filter	(nullptr to OTHER match SELECTIONFILTERBIT_)
enum DISPLAYFILTER
{
	DISPLAYFILTER_0									 = 0,
	DISPLAYFILTER_NULL							 = (1 << 0),
	DISPLAYFILTER_POLYGON						 = (1 << 1),
	DISPLAYFILTER_SPLINE						 = (1 << 2),
	DISPLAYFILTER_GENERATOR					 = (1 << 3),
	DISPLAYFILTER_HYPERNURBS				 = (1 << 4),
	DISPLAYFILTER_UNUSED1						 = (1 << 5),
	DISPLAYFILTER_DEFORMER					 = (1 << 6),
	DISPLAYFILTER_CAMERA						 = (1 << 7),
	DISPLAYFILTER_LIGHT							 = (1 << 8),
	DISPLAYFILTER_SCENE							 = (1 << 9),
	DISPLAYFILTER_PARTICLE					 = (1 << 10),
	DISPLAYFILTER_OTHER							 = (1 << 11),
	DISPLAYFILTER_GRID							 = (1 << 13),
	DISPLAYFILTER_HORIZON						 = (1 << 14),
	DISPLAYFILTER_WORLDAXIS					 = (1 << 15),
	DISPLAYFILTER_BOUNDS						 = (1 << 16),
	DISPLAYFILTER_HUD								 = (1 << 17),
	DISPLAYFILTER_SDS								 = (1 << 18),
	DISPLAYFILTER_HIGHLIGHTING			 = (1 << 19),
	DISPLAYFILTER_MULTIAXIS					 = (1 << 20),
	DISPLAYFILTER_OBJECTHANDLES			 = (1 << 21),
	DISPLAYFILTER_HANDLEBANDS				 = (1 << 22),
	DISPLAYFILTER_SDSCAGE						 = (1 << 23),
	DISPLAYFILTER_NGONLINES					 = (1 << 24),
	DISPLAYFILTER_JOINT							 = (1 << 25),
	DISPLAYFILTER_OBJECTHIGHLIGHTING = (1 << 26),
	DISPLAYFILTER_GUIDELINES				 = (1 << 27),
	DISPLAYFILTER_POI								 = (1 << 28),
	DISPLAYFILTER_GRADIENT					 = (1 << 29)
} mixin ENUM_END_FLAGS!(DISPLAYFILTER);

enum DISPLAYEDITSTATE
{
	DISPLAYEDITSTATE_0				= 0,
	DISPLAYEDITSTATE_SDS			= (1 << 0),
	DISPLAYEDITSTATE_DEFORM		= (1 << 1),

	DISPLAYEDITSTATE_DOCUMENT	= -1
} mixin ENUM_END_FLAGS!(DISPLAYEDITSTATE);

enum THREADTYPE
{
	THREADTYPE_0							= 0,
	THREADTYPE_EDITORREDRAW		= (1 << 0),
	THREADTYPE_RENDEREDITOR		= (1 << 1),
	THREADTYPE_RENDEREXTERNAL	= (1 << 2)
} mixin ENUM_END_FLAGS!(THREADTYPE);

enum RENDERPROGRESSTYPE
{
	RENDERPROGRESSTYPE_BEFORERENDERING		= 0,
	RENDERPROGRESSTYPE_DURINGRENDERING		= 1,
	RENDERPROGRESSTYPE_AFTERRENDERING			= 2,
	RENDERPROGRESSTYPE_GLOBALILLUMINATION	= 3
} mixin ENUM_END_LIST!(RENDERPROGRESSTYPE);

enum RDATA_SAVECALLBACK_CMD
{
	RDATA_SAVECALLBACK_CMD_OPEN	 = 1,
	RDATA_SAVECALLBACK_CMD_WRITE = 2,
	RDATA_SAVECALLBACK_CMD_CLOSE = 3
} mixin ENUM_END_LIST!(RDATA_SAVECALLBACK_CMD);

enum VPGETINFO
{
	VPGETINFO_XRESOLUTION	= 0,
	VPGETINFO_YRESOLUTION	= 1,
	VPGETINFO_BITDEPTH		= 2,
	VPGETINFO_CPP					= 3,
	VPGETINFO_VISIBLE			= 4,
	VPGETINFO_LINEOFFSET	= 5	// offset of component in line
} mixin ENUM_END_LIST!(VPGETINFO);

enum DRAWOBJECT
{
	DRAWOBJECT_0								= 0,
	DRAWOBJECT_FORCELINES				= (1 << 0),
	DRAWOBJECT_NOBACKCULL				= (1 << 1),
	DRAWOBJECT_LOCALMATRIX			= (1 << 2),
	DRAWOBJECT_EDITMODE					= (1 << 3),
	DRAWOBJECT_FORCEBASE				= (1 << 9),
	DRAWOBJECT_FORCEPOINTS			= (1 << 10),
	DRAWOBJECT_NO_EOGL					= (1 << 11),
	DRAWOBJECT_USE_OBJECT_COLOR = (1 << 12),
	DRAWOBJECT_USE_CUSTOM_COLOR = (1 << 13),
	DRAWOBJECT_XRAY_ON					= (1 << 14),
	DRAWOBJECT_XRAY_OFF					= (1 << 15),
	DRAWOBJECT_IMMEDIATELY			= (1 << 16),
	DRAWOBJECT_Z_OFFSET					= (1 << 17),	// don't change the Z offset during DrawObject
	DRAWOBJECT_PRIVATE_ANY			= (1 << 30)
} mixin ENUM_END_FLAGS!(DRAWOBJECT);

enum RENDERFLAGS
{
	RENDERFLAGS_0										 = 0,
	RENDERFLAGS_EXTERNAL						 = (1 << 0),
	RENDERFLAGS_NODOCUMENTCLONE			 = (1 << 1),
	RENDERFLAGS_SHOWERRORS					 = (1 << 2),
	RENDERFLAGS_PREVIEWRENDER				 = (1 << 3),
	RENDERFLAGS_IRR									 = (1 << 4),	// Render in Interactive Render Region
	RENDERFLAGS_CREATE_PICTUREVIEWER = (1 << 5),	// Render in Picture Viewer
	RENDERFLAGS_OPEN_PICTUREVIEWER	 = (1 << 6),
	RENDERFLAGS_KEEP_CONTEXT				 = (1 << 7),	// private
	RENDERFLAGS_BATCHRENDER					 = (1 << 8),	// Render in Batch Render - private
	RENDERFLAGS_NET									 = (1 << 9)		// Use NET System for rendering
} mixin ENUM_END_FLAGS!(RENDERFLAGS);

enum WRITEMODE
{
	WRITEMODE_STANDARD = 0,
	WRITEMODE_ASSEMBLE_MOVIE = 1,
	WRITEMODE_ASSEMBLE_SINGLEIMAGE = 2
} mixin ENUM_END_LIST!(WRITEMODE);

enum NETRENDERFLAGS
{
	NETRENDERFLAGS_0														 = 0,
	NETRENDERFLAGS_OPEN_PICTUREVIEWER						 = (1 << 0),
	NETRENDERFLAGS_SHOWERRORS										 = (1 << 2),
	NETRENDERFLAGS_DELETEAFTERRENDERING					 = (1 << 3),
	NETRENDERFLAGS_NOPEERTOPEERASSETDISTRIBUTION = (1 << 4),
	NETRENDERFLAGS_NOREQUESTONDEMAND						 = (1 << 5),
	NETRENDERFLAGS_EXCLUDECLIENTONRENDERINGERROR = (1 << 6),
	NETRENDERFLAGS_SAVERESULTSINREPOSITORY			 = (1 << 7),
	NETRENDERFLAGS_ASSEMBLEB3DFILESIMMEDIATLEY	 = (1 << 8),
	NETRENDERFLAGS_NOWRITETEST									 = (1 << 9)
} mixin ENUM_END_FLAGS!(NETRENDERFLAGS);

enum CHECKISRUNNING
{
	CHECKISRUNNING_ANIMATIONRUNNING				= 0,
	CHECKISRUNNING_VIEWDRAWING						= 1,
	CHECKISRUNNING_EDITORRENDERING				= 2,
	CHECKISRUNNING_EXTERNALRENDERING			= 3,
	CHECKISRUNNING_PAINTERUPDATING				= 4,
	CHECKISRUNNING_MATERIALPREVIEWRUNNING	= 5,
	CHECKISRUNNING_EVENTSYSTEM						= 6
} mixin ENUM_END_LIST!(CHECKISRUNNING);

enum BAKE_TEX_ERR
{
	BAKE_TEX_ERR_NONE								= 0,
	BAKE_TEX_ERR_NO_DOC							= 3000,	// no document
	BAKE_TEX_ERR_NO_MEM							= 3001,	// no more memory available
	BAKE_TEX_ERR_NO_RENDER_DOC			= 3002,	// no render document
	BAKE_TEX_ERR_NO_TEXTURE_TAG			= 3003,	// textag is nullptr or not in doc
	BAKE_TEX_ERR_NO_OBJECT					= 3004,	// one of the tags is not assigned to an object or to another object
	BAKE_TEX_ERR_NO_UVW_TAG					= 3005,	// UVW Tag is missing
	BAKE_TEX_ERR_TEXTURE_MISSING		= 3006,	// no texture
	BAKE_TEX_ERR_WRONG_BITMAP				= 3007,	// MultipassBitmap was used, but it has the wrong type or wrong resolution
	BAKE_TEX_ERR_USERBREAK					= 3008,	// user break
	BAKE_TEX_ERR_NO_OPTIMAL_MAPPING	= 3009,	// optimal mapping failed
	BAKE_TEX_ERR_NO_SOURCE_UVW_TAG	= 3010	// UVW Tag for the source object is missing
} mixin ENUM_END_LIST!(BAKE_TEX_ERR);

enum GL_MESSAGE
{
	GL_MESSAGE_OK							 = 1,
	GL_MESSAGE_ERROR					 = 0,
	GL_MESSAGE_FORCE_EMULATION = 2
} mixin ENUM_END_LIST!(GL_MESSAGE);

enum VIEWPORT_PICK_FLAGS
{
	VIEWPORT_PICK_FLAGS_0													= 0,
	VIEWPORT_PICK_FLAGS_ALLOW_OGL									= (1 << 0),
	VIEWPORT_PICK_FLAGS_DONT_STOP_THREADS					= (1 << 1),
	VIEWPORT_PICK_FLAGS_USE_SEL_FILTER						= (1 << 2),
	VIEWPORT_PICK_FLAGS_OGL_ONLY_TOPMOST					= (1 << 3),	// use this only when you don't need the object pointer, does only work with OpenGL
	VIEWPORT_PICK_FLAGS_OGL_ONLY_VISIBLE					= (1 << 4),	// this has only an effect when the PickObject functions are called that take ViewportPixel as argument
	VIEWPORT_PICK_FLAGS_OGL_IGNORE_Z							= (1 << 5),	// set this if you are only interested if (and which) an object was hit, not its Z position
	VIEWPORT_PICK_FLAGS_OGL_ONLY_TOPMOST_WITH_OBJ	= (1 << 6)	// only returns the topmost object with its Z position
} mixin ENUM_END_FLAGS!(VIEWPORT_PICK_FLAGS);

// HandleShaderPopup
enum SHADERPOPUP_SETSHADER =				 99989;
enum SHADERPOPUP_SETFILENAME =			 99990;
enum SHADERPOPUP_LOADIMAGE =				 99991;
enum SHADERPOPUP_EDITPARAMS =			 99999;
enum SHADERPOPUP_RELOADIMAGE =			 99998;
enum SHADERPOPUP_EDITIMAGE =				 99997;
enum SHADERPOPUP_COPYCHANNEL =			 99995;
enum SHADERPOPUP_PASTECHANNEL =		 99994;
enum SHADERPOPUP_CREATENEWTEXTURE = 99993;
enum SHADERPOPUP_CLEARSHADER =			 99992;

enum DEFAULTFILENAME_SHADER_SURFACES =	1001;
enum DEFAULTFILENAME_SHADER_EFFECTS =	1002;
enum DEFAULTFILENAME_SHADER_VOLUME =		1003;

// Background handler
enum BACKGROUNDHANDLERCOMMAND
{
	BACKGROUNDHANDLERCOMMAND_ISRUNNING = 100,
	BACKGROUNDHANDLERCOMMAND_STOP			 = 101,
	BACKGROUNDHANDLERCOMMAND_START		 = 102,
	BACKGROUNDHANDLERCOMMAND_REMOVE		 = 103
} mixin ENUM_END_LIST!(BACKGROUNDHANDLERCOMMAND);

enum BACKGROUNDHANDLER_PRIORITY_RENDERACTIVEMATERIAL =		 5000;
enum BACKGROUNDHANDLER_PRIORITY_REDRAWVIEW =							 4000;
enum BACKGROUNDHANDLER_PRIORITY_RENDERINACTIVEMATERIALS = 3000;
enum BACKGROUNDHANDLER_PRIORITY_RENDEREXTERNAL =					 -1000;
enum BACKGROUNDHANDLER_PRIORITY_REDRAWANTS =							 -2000;

enum BACKGROUNDHANDLERFLAGS
{
	BACKGROUNDHANDLERFLAGS_0									= 0,
	BACKGROUNDHANDLERFLAGS_VIEWREDRAW					= (1 << 0),
	BACKGROUNDHANDLERFLAGS_EDITORRENDDER			= (1 << 1),
	BACKGROUNDHANDLERFLAGS_MATERIALPREVIEW		= (1 << 2),
	BACKGROUNDHANDLERFLAGS_RENDEREXTERNAL			= (1 << 3),
	BACKGROUNDHANDLERFLAGS_PRIVATE_VIEWREDRAW	= (1 << 4),

	BACKGROUNDHANDLERFLAGS_SHUTDOWN						= -1
} mixin ENUM_END_FLAGS!(BACKGROUNDHANDLERFLAGS);

enum BACKGROUNDHANDLER_TYPECLASS_C4D =	1000;

// Identify File
enum IDENTIFYFILE
{
	IDENTIFYFILE_0						 = 0,
	IDENTIFYFILE_SCENE				 = (1 << 0),
	IDENTIFYFILE_IMAGE				 = (1 << 1),
	IDENTIFYFILE_MOVIE				 = (1 << 2),
	IDENTIFYFILE_SKIPQUICKTIME = (1 << 3),
	IDENTIFYFILE_SCRIPT				 = (1 << 4),
	IDENTIFYFILE_COFFEE				 = (1 << 5),
	IDENTIFYFILE_SOUND				 = (1 << 6),
	IDENTIFYFILE_LAYOUT				 = (1 << 7),
	IDENTIFYFILE_PYTHON				 = (1 << 8)
} mixin ENUM_END_FLAGS!(IDENTIFYFILE);

enum CALCHARDSHADOW
{
	CALCHARDSHADOW_0								 = 0,
	CALCHARDSHADOW_TRANSPARENCY			 = (1 << 0),
	CALCHARDSHADOW_SPECIALGISHADOW	 = (1 << 29),
	CALCHARDSHADOW_SPECIALSELFSHADOW = (1 << 30)
} mixin ENUM_END_FLAGS!(CALCHARDSHADOW);

enum ILLUMINATEFLAGS
{
	ILLUMINATEFLAGS_0																 = 0,
	ILLUMINATEFLAGS_SHADOW													 = (1 << 0),
	ILLUMINATEFLAGS_NOENVIRONMENT										 = (1 << 1),
	ILLUMINATEFLAGS_DISABLESHADOWMAP_CORRECTION			 = (1 << 20),
	ILLUMINATEFLAGS_DISABLESHADOWCASTERMP_CORRECTION = (1 << 21),
	ILLUMINATEFLAGS_LIGHTDIRNORMALS									 = (1 << 22),
	ILLUMINATEFLAGS_NODISTANCEFALLOFF								 = (1 << 23),
	ILLUMINATEFLAGS_NOGRAIN													 = (1 << 24),
	ILLUMINATEFLAGS_BACKLIGHT												 = (1 << 25)
} mixin ENUM_END_FLAGS!(ILLUMINATEFLAGS);

enum RAYBIT
{
	RAYBIT_0								 = 0,
	RAYBIT_REFLECTION				 = (1 << 0),	// ray chain contains a reflection ray
	RAYBIT_TRANSPARENCY			 = (1 << 1),	// ray chain contains a transparency ray (note: refractions are not contained)
	RAYBIT_REFRACTION				 = (1 << 2),	// ray chain contains a refraction ray
	RAYBIT_CUSTOM						 = (1 << 3),	// ray chain contains a custom ray

	RAYBIT_CURR_REFLECTION	 = (1 << 4),	// current ray is a reflection ray
	RAYBIT_CURR_TRANSPARENCY = (1 << 5),	// current ray is a transparency ray
	RAYBIT_CURR_REFRACTION	 = (1 << 6),	// current ray is a refraction ray
	RAYBIT_CURR_CUSTOM			 = (1 << 7),	// current ray is a custom ray

	RAYBIT_VOLUMETRICLIGHT	 = (1 << 8),	// current ray is used to calculate a volumetric light
	RAYBIT_ALLOWVLMIX				 = (1 << 9),	// custom mixing of visible light sources allowed for this ray; bit must be deleted by shader if used

	RAYBIT_GI								 = (1 << 10),	// current ray is a Global Illumination ray
	RAYBIT_BLURRY						 = (1 << 11),	// current ray is a blurry ray
	RAYBIT_SSS							 = (1 << 12),	// current ray is a subsurface ray

	RAYBIT_AO								 = (1 << 13),	// current ray is an Ambient Occlusion ray
	RAYBIT_COMPOSITING			 = (1 << 14)	// current ray is a compositing ray
} mixin ENUM_END_FLAGS!(RAYBIT);

enum VOLUMEINFO
{
	VOLUMEINFO_0									= 0,
	VOLUMEINFO_REFLECTION					= 0x00000002,	// shader calculates reflections
	VOLUMEINFO_TRANSPARENCY				= 0x00000004,	// shader calculates transparency
	VOLUMEINFO_ALPHA							= 0x00000008,	// shader calculates alpha
	VOLUMEINFO_CHANGENORMAL				= 0x00002000,	// shader calculates bump mapping
	VOLUMEINFO_DISPLACEMENT				= 0x00004000,	// shader calculates displacement mapping
	VOLUMEINFO_ENVREQUIRED				= 0x00100000,	// shader needs environment reflection data
	VOLUMEINFO_DUDVREQUIRED				= 0x00200000,	// shader needs du/dv bump mapping data
	VOLUMEINFO_MIPSAT							= 0x02000000,	// shader requires MIP/SAT data
	VOLUMEINFO_VOLUMETRIC					= 0x20000000,	// shader is a volumetric shader
	VOLUMEINFO_TRANSFORM					= 0x00000010,	// shader needs back-transformed data
	VOLUMEINFO_EVALUATEPROJECTION	= 0x04000000,	// shader requires texture tag projections
	VOLUMEINFO_PRIVATE_GLOW				= 0x10000000,	// shader calculates glow (private)
	VOLUMEINFO_INITCALCULATION		= 0x80000000	// shader needs initcalculation call
} mixin ENUM_END_FLAGS!(VOLUMEINFO);

enum VIDEOPOSTINFO
{
	VIDEOPOSTINFO_0											 = 0,
	VIDEOPOSTINFO_STOREFRAGMENTS				 = (1 << 0),	// VP needs fragment information for whole image at VP_INNER/VP_RENDER
	VIDEOPOSTINFO_EXECUTELINE						 = (1 << 4),	// line override
	VIDEOPOSTINFO_EXECUTEPIXEL					 = (1 << 5),	// pixel override
	VIDEOPOSTINFO_REQUEST_MOTIONMATRIX	 = (1 << 6),
	VIDEOPOSTINFO_REQUEST_MOTIONGEOMETRY = (1 << 7),
	VIDEOPOSTINFO_CALCVOLUMETRIC				 = (1 << 8),
	VIDEOPOSTINFO_CALCSHADOW						 = (1 << 9),
	VIDEOPOSTINFO_CUSTOMLENS						 = (1 << 10),
	VIDEOPOSTINFO_GLOBALILLUMINATION		 = (1 << 11),	// post effect is GI hook
	VIDEOPOSTINFO_CAUSTICS							 = (1 << 12),	// post effect is Caustics hook
	VIDEOPOSTINFO_CUSTOMLENS_EXTENDED		 = (1 << 13),	// post effect is extended lens for physical render
	VIDEOPOSTINFO_NETFRAME							 = (1 << 14),	// post effect is Net Frame hook
	VIDEOPOSTINFO_NETRUNONSERVER				 = (1 << 15),	// post effect can be run on the Net Server
	VIDEOPOSTINFO_NETCREATEBUFFER				 = (1 << 16),	// post effect creates a buffer for Net Client
} mixin ENUM_END_FLAGS!(VIDEOPOSTINFO);

enum SHADERINFO
{
	SHADERINFO_0								 = 0,
	SHADERINFO_TRANSFORM				 = 0x00000004,	// channel shader needs back-transformed data
	SHADERINFO_BUMP_SUPPORT			 = 0x00000010,	// channel shader supports new bump system (strongly recommended for all shader but simple 2d (UV) samplers)
	SHADERINFO_ALPHA_SUPPORT		 = 0x00000020,	// channel shader supports alpha output
	SHADERINFO_REFLECTIONS			 = 0x00000040,	// channel shader computes reflections
	SHADERINFO_DUDVREQUIRED			 = 0x00000080,	// channel shader needs du/dv bump mapping data
	SHADERINFO_DYNAMICSUBSHADERS = 0x00000100		// channel shader has a dynamic list of sub shaders in its descriptions
} mixin ENUM_END_FLAGS!(SHADERINFO);

enum SAMPLEBUMP
{
	SAMPLEBUMP_0					= 0,
	SAMPLEBUMP_MIPFALLOFF	= (1 << 0)
};

enum INITCALCULATION
{
	INITCALCULATION_SURFACE			 = 0,
	INITCALCULATION_TRANSPARENCY = 1,
	INITCALCULATION_DISPLACEMENT = 3
} mixin ENUM_END_LIST!(INITCALCULATION);

// COFFEE Scripts
enum ID_SCRIPTFOLDER =	1026688;
enum ID_COFFEESCRIPT =	1001085;
enum ID_PYTHONSCRIPT =	1026256;

enum COFFEESCRIPT_TEXT =					1000;
enum COFFEESCRIPT_SHOWINMENU =		1002;
enum COFFEESCRIPT_ADDEVENT =			1003;
enum COFFEESCRIPT_SCRIPTENABLE =	1006;

enum COFFEESCRIPT_CONTAINER = 65536;	// + language identification

enum COFFEESCRIPT_SCRIPTNAME =	1;
enum COFFEESCRIPT_SCRIPTHELP =	2;

enum MSG_SCRIPT_EXECUTE =				1001184;	// no arguments
enum MSG_SCRIPT_RETRIEVEBITMAP =	1001185;	// pass pointer to bitmap pointer

enum PYTHONSCRIPT_TEXT =					1000;
enum PYTHONSCRIPT_SHOWINMENU =		1002;
enum PYTHONSCRIPT_ADDEVENT =			1003;
enum PYTHONSCRIPT_SCRIPTENABLE =	1006;

enum PYTHONSCRIPT_CONTAINER = 65536;	// + language identification

enum PYTHONSCRIPT_SCRIPTNAME =	1;
enum PYTHONSCRIPT_SCRIPTHELP =	2;

enum BASEDRAW_DRAWPORTTYPE =			 1888;
enum BASEDRAW_IS_SHADOWPASS =		 1889;
enum BASEDRAW_IS_RENDERASEDITOR = 1890;
enum BASEDRAW_IS_OGL_PREPASS =		 1891;
enum BASEDRAW_IS_PICK_OBJECT =		 1892;

enum MULTIPASSCHANNEL
{
	MULTIPASSCHANNEL_0							 = 0,
	MULTIPASSCHANNEL_IMAGELAYER			 = (1 << 0),
	MULTIPASSCHANNEL_MATERIALCHANNEL = (1 << 1)
} mixin ENUM_END_LIST!(MULTIPASSCHANNEL);

enum DLG_TYPE
{
	DLG_TYPE_MODAL = 10,
	DLG_TYPE_MODAL_RESIZEABLE,

	DLG_TYPE_ASYNC = 20,
	DLG_TYPE_ASYNC_POPUP_RESIZEABLE,
	DLG_TYPE_ASYNC_POPUPEDIT,

	DLG_TYPE_ASYNC_FULLSCREEN_WORK = 30,
	DLG_TYPE_ASYNC_FULLSCREEN_MONITOR,

	DLG_TYPE_
} mixin ENUM_END_LIST!(DLG_TYPE);

enum MULTIMSG_ROUTE
{
	MULTIMSG_ROUTE_NONE			 = 0,
	MULTIMSG_ROUTE_UP				 = 1,
	MULTIMSG_ROUTE_ROOT			 = 2,
	MULTIMSG_ROUTE_DOWN			 = 3,
	MULTIMSG_ROUTE_BROADCAST = 4
} mixin ENUM_END_LIST!(MULTIMSG_ROUTE);

enum VPGETFRAGMENTS
{
	VPGETFRAGMENTS_0	 = 0,
	VPGETFRAGMENTS_Z_P = (1 << 0),
	VPGETFRAGMENTS_N	 = (1 << 1)
} mixin ENUM_END_FLAGS!(VPGETFRAGMENTS);

enum MSG_GICSEX =					 1000969;
enum MSG_GINEW =						 1021096;
enum ID_OLDCAUSTICS =			 1000970;
enum VPglobalillumination = 1021096;
enum VPGIShadingChain =		 1026950;
enum VPAOShadingChain =		 1029427;

enum SIGNALMODE
{
	SIGNALMODE_DEFAULT	= 0,
	SIGNALMODE_RESERVED	= 1
} mixin ENUM_END_LIST!(SIGNALMODE);

enum QUALIFIER
{
	QUALIFIER_0				 = 0,
	QUALIFIER_SHIFT		 = (1 << 0),
	QUALIFIER_CTRL		 = (1 << 1),
	QUALIFIER_MOUSEHIT = (1 << 10)
} mixin ENUM_END_FLAGS!(QUALIFIER);

/*
enum CODEEDITOR_SETMODE =				 'setm';
enum CODEEDITOR_GETSTRING =			 'gets';
enum CODEEDITOR_SETSTRING =			 'sets';
enum CODEEDITOR_COMPILE =				 'comp';
enum CODEEDITOR_GETERROR_RES =		 'resr';
enum CODEEDITOR_GETERROR_STRING = 'ress';
enum CODEEDITOR_GETERROR_LINE =	 'resl';
enum CODEEDITOR_GETERROR_POS =		 'resp';
enum CODEEDITOR_EXECUTE =				 'exec';
enum CODEEDITOR_DISABLEUNDO =		 'dsud';
*/

enum
{
	DIALOG_PIN = 1,											// Int32 flags
	DIALOG_CHECKBOX,										// Int32 id, Int32 flags, String *name
	DIALOG_STATICTEXT,									// Int32 id, Int32 flags, String *name, Int32 borderstyle
	DIALOG_BUTTON,											// Int32 id, Int32 flags, String *name
	DIALOG_ARROWBUTTON,									// Int32 id, Int32 flags, Int32 arrowtype
	DIALOG_EDITTEXT,										// Int32 id, Int32 flags
	DIALOG_EDITNUMBER,									// Int32 id, Int32 flags
	DIALOG_EDITNUMBERUD,								// Int32 id, Int32 flags
	DIALOG_EDITSLIDER,									// Int32 id, Int32 flags
	DIALOG_SLIDER,											// Int32 id, Int32 flags
	DIALOG_COLORFIELD,									// Int32 id, Int32 flags
	DIALOG_COLORCHOOSER,								// Int32 id, Int32 flags
	DIALOG_USERAREA,										// Int32 id, Int32 flags
	DIALOG_RADIOGROUP,									// Int32 id, Int32 flags
	DIALOG_COMBOBOX,										// Int32 id, Int32 flags
	DIALOG_POPUPBUTTON,									// Int32 id, Int32 flags
	DIALOG_CHILD,												// Int32 id, Int32 subid, String *child);
	DIALOG_FREECHILDREN,								// Int32 id
	DIALOG_DLGGROUP,										// Int32 flags
	DIALOG_SETTITLE,										// String *name
	DIALOG_GROUPSPACE,									// spacex,spacey
	DIALOG_GROUPBORDER,									// borderstyle
	DIALOG_GROUPBORDERSIZE,							// left, top, right, bottom
	DIALOG_SETIDS,											// left, top, right, bottom
	DIALOG_LAYOUTCHANGED,								// relayout dialog
	DIALOG_ACTIVATE,										// activate gadget
	DIALOG_ADDSUBMENU,									// add submenu, text
	DIALOG_ENDSUBMENU,									// add submenu, text
	DIALOG_ADDMENUCMD,									// add menutext, text, cmdid
	DIALOG_FLUSHMENU,										// delete all menu entries
	DIALOG_INIT,												// create new layout
	DIALOG_CHECKNUMBERS,								// range check of all dialog elements
	DELME_DIALOG_SETGROUP,							// set group as insert group
	DIALOG_FLUSHGROUP,									// flush all elements of this group and set insert point to this group
	DIALOG_SETMENU,											// set and display menu in manager
	DIALOG_SCREEN2LOCALX,								// Screen2Local coordinates
	DIALOG_SCREEN2LOCALY,								// Screen2Local coordinates
	DIALOG_ADDMENUSTR,									// add menutext, text, id
	DIALOG_RADIOBUTTON,									// Int32 id, Int32 flags, String *name
	DIALOG_ADDMENUSEP,									// add menu separator
	DIALOG_SEPARATOR,										// add separator
	DIALOG_MULTILINEEDITTEXT,						// add multiline editfield
	DIALOG_INITMENUSTR,									// enable/disable/check/uncheck menustrings
	DIALOG_RADIOTEXT,
	DIALOG_MENURESOURCE,								// private for painter
	DIALOG_LISTVIEW,										// Int32 id, Int32 flags
	DIALOG_SUBDIALOG,										// Int32 id, Int32 flags
	DIALOG_CHECKCLOSE,									// CheckCloseMessage for dialog
	DIALOG_GETTRISTATE,									// get TriState-flag of the specified gadget
	DIALOG_SDK,													// Int32 id, Int32 flags, String *name
	DIALOG_SCROLLGROUP,									// create ScrollGroup
	DIALOG_ISOPEN,											// returns true if the dialog is open
	DIALOG_REMOVEGADGET,								// removes an element from the layout
	DIALOG_MENUGROUPBEGIN,
	DIALOG_NOMENUBAR,										// removes the menubar
	DIALOG_SAVEWEIGHTS,									// store the weights of a group
	DIALOG_LOADWEIGHTS,									// restore the weights of a group
	DIALOG_EDITSHORTCUT,								// editfield to enter shortcuts
	DIALOG_ISVISIBLE,										// returns true if the dialog is visible (e.g. false if tabbed behind)
	DIALOG_HIDEELEMENT,									// true - hides the element
	DIALOG_SETDEFAULTCOLOR,							// set the mapcolor for an color to anotehr value e.g. COLOR_BG = 1,1,1
	DIALOG_COMBOBUTTON,									// ComboButton
	DIALOG_PRIVATE_NOSTOPEDITORTHREADS,	// no params

	DIALOG_
};

enum EDITTEXT_PASSWORD =	(1 << 0);	// creates a passwordfield
enum EDITTEXT_HELPTEXT =	(1 << 1);	// sets the helptext for an editfield, this text appears if the editfield is empty

enum
{
	LV_GETLINECOUNT						 = 1,	// request the number of lines of the listview
	LV_GETCOLUMNCOUNT					 = 2,	// request the number of columns of listview
	LV_GETLINEHEIGHT					 = 3,	// ask for the line height of the specific 'line'
	LV_GETCOLUMNWIDTH					 = 4,	// ask for the width of the specific 'column' in 'line'
	LV_GETCOLUMTYPE						 = 5,	// ask for the type of the column in 'line',
	LV_COLUMN_TEXT						 = C4D_FOUR_BYTE(0, 't', 'x', 't'),
	LV_COLUMN_EDITTEXT				 = C4D_FOUR_BYTE(0, 'e', 'd', 't'),
	LV_COLUMN_BMP							 = C4D_FOUR_BYTE(0, 'b', 'm', 'p'),
	LV_COLUMN_CHECKBOX				 = C4D_FOUR_BYTE(0, 'c', 'h', 'k'),
	LV_COLUMN_BUTTON					 = C4D_FOUR_BYTE(0, 'b', 't', 'n'),
	LV_COLUMN_USERDRAW				 = C4D_FOUR_BYTE(0, 'u', 's', 'r'),
	LV_COLUMN_COLORVIEW				 = C4D_FOUR_BYTE(0, 'c', 'l', 'v'),

	LV_GETCOLUMDATA						 = 6,		// ask for the data of the column in 'line',
	LV_GETLINESELECTED				 = 7,		// ask if the line is selected
	LV_GETCOLSPACE						 = 8,		// ask for space in pixels between two columns
	LV_GETLINESPACE						 = 9,		// ask for space in pixels between two lines
	LV_GETFIXEDLAYOUT					 = 10,	// ask for fixed layout: false...indiv. layout, true...fixed layout
	LV_DESTROYLISTVIEW				 = 11,	// destroy listview and all data
	LV_INITCACHE							 = 12,	// (internal) before call the listview
	LV_NOAUTOCOLUMN						 = 13,	// ask for fast layout: false...eachline is ask for the width, true...only the first line is asked for the columnwidth -> huge speedup

	LV_LMOUSEDOWN							 = 50,	// mouse down at line, col,
	LV_ACTION									 = 51,	// gadget command, col, data1 = msg,
	LV_USERDRAW								 = 52,
	LV_REDRAW									 = 53,	// redraw the listview (supermessage)
	LV_DATACHANGED						 = 54,	// layout data has changed
	LV_SHOWLINE								 = 55,	// scroll line into the visible area
	LV_DRAGRECEIVE						 = 56,	// drag receive
	LV_RMOUSEDOWN							 = 57,	// mouse down at line, col,

	LV_SIMPLE_SELECTIONCHANGED = 100,	// simplelistview: selection changed
	LV_SIMPLE_CHECKBOXCHANGED	 = 101,	// simplelistview: checkbox changed
	LV_SIMPLE_FOCUSITEM				 = 102,	// simplelistview: set focus to item
	LV_SIMPLE_BUTTONCLICK			 = 103,	// simplelistview: button click
	LV_SIMPLE_ITEM_ID					 = 1,
	LV_SIMPLE_COL_ID					 = 2,
	LV_SIMPLE_DATA						 = 3,
	LV_SIMPLE_DOUBLECLICK			 = 104,	// doubleclick occured
	LV_SIMPLE_FOCUSITEM_NC		 = 105,	// focus item, but no change
	LV_SIMPLE_RMOUSE					 = 106,
	LV_SIMPLE_USERDRAW				 = 107,

	// result types
	LV_RES_INT	  = C4D_FOUR_BYTE('l', 'o', 'n', 'g'),//'long',
	LV_RES_BITMAP = C4D_FOUR_BYTE(0, 'b', 'm', 'p'),
	LV_RES_STRING = C4D_FOUR_BYTE('s', 't', 'r', 'g'),//'strg',
	LV_RES_VECTOR = C4D_FOUR_BYTE(0, 'v', 'e', 'c'),
	LV_RES_NIL	  = C4D_FOUR_BYTE(0, 'n', 'i', 'l'),

	LV__
};

/*
#ifndef C4D_GL_VARS_DEFINED
enum GlVertexBufferSubBufferType { VBArrayBuffer = 0, VBElementArrayBuffer16 = 1, VBElementArrayBuffer32 = 2 };
enum GlVertexBufferAccessFlags { VBReadWrite = 0, VBReadOnly = 1, VBWriteOnly = 2 };

#if defined __PC
typedef	UINT C4DGLuint;
typedef INT C4DGLint;
#elif defined __MAC
typedef unsigned int C4DGLuint;
typedef int	C4DGLint;
#elif defined __LINUX
typedef	UINT C4DGLuint;
typedef INT C4DGLint;
#endif

typedef Int GlProgramParameter;
#define C4D_GL_VARS_DEFINED
#endif


#ifndef _C4D_GL_H_
enum GlProgramType { VertexProgram = 1, FragmentProgram = 2, CompiledProgram = 3, GeometryProgram = 4 };
enum GlUniformParamType { UniformFloat1					 = 0, UniformFloat2 = 1, UniformFloat3 = 2, UniformFloat4 = 3,
UniformInt1						 = 4, UniformInt2 = 5, UniformInt3 = 6, UniformInt4 = 7,
UniformUint1					 = 8, UniformUint2 = 9, UniforUint3 = 10, UniformUint4 = 11,
UniformFloatMatrix2		 = 12, UniformFloatMatrix3 = 13, UniformFloatMatrix4 = 14,
UniformTexture1D			 = 15, UniformTexture2D = 16, UniformTexture3D = 17, UniformTextureCube = 18,
UniformTexture1Di			 = 19, UniformTexture2Di = 20, UniformTexture3Di = 21, UniformTextureCubei = 22,
UniformTexture1Du			 = 23, UniformTexture2Du = 24, UniformTexture3Du = 25, UniformTextureCubeu = 26,
UniformTexture1DArray	 = 27, UniformTexture2DArray = 28,
UniformTexture1DArrayi = 29, UniformTexture2DArrayi = 30,
UniformTexture1DArrayu = 31, UniformTexture2DArrayu = 32 };
#endif
*/

alias UChar PIX;

enum NOTIFY_EVENT
{
	NOTIFY_EVENT_NONE				 = -1,
	NOTIFY_EVENT_ALL				 = 10,
	NOTIFY_EVENT_ANY				 = 11,
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_PRE_DEFORM	 = 100,
	NOTIFY_EVENT_POST_DEFORM = 101,
	NOTIFY_EVENT_UNDO				 = 102,
	NOTIFY_EVENT_MESSAGE		 = 103,	// NotifyEventMsg
	NOTIFY_EVENT_FREE				 = 104,
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_COPY				 = 107,
	NOTIFY_EVENT_CACHE			 = 108,
	NOTIFY_EVENT_REMOVE			 = 109,
	NOTIFY_EVENT_CLONE			 = 110,
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_SETNAME		 = 200,
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_0					 = 0
} mixin ENUM_END_LIST!(NOTIFY_EVENT);

enum NOTIFY_EVENT_FLAG
{
	NOTIFY_EVENT_FLAG_REMOVED				 = (1 << 0),	// PRIVATE
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_FLAG_COPY_UNDO			 = (1 << 10),
	NOTIFY_EVENT_FLAG_COPY_CACHE		 = (1 << 11),
	NOTIFY_EVENT_FLAG_COPY_DUPLICATE = (1 << 12),
	NOTIFY_EVENT_FLAG_ONCE					 = (1 << 13),
	NOTIFY_EVENT_FLAG_COPY					 = ((1 << 10) | (1 << 11) | (1 << 12)),
	//////////////////////////////////////////////////////////////////////////
	NOTIFY_EVENT_FLAG_0							 =0
} mixin ENUM_END_FLAGS!(NOTIFY_EVENT_FLAG);

enum DESCIDSTATE
{
	DESCIDSTATE_0			 = 0,
	DESCIDSTATE_LOCKED = 1 << 0,
	DESCIDSTATE_HIDDEN = 1 << 1
} mixin ENUM_END_FLAGS!(DESCIDSTATE);

enum BASEDRAW_HOOK_MESSAGE
{
	BASEDRAW_MESSAGE_ADAPTVIEW				= 1,
	BASEDRAW_MESSAGE_SET_SCENE_CAMERA	= 2,
	BASEDRAW_MESSAGE_DELETEBASEDRAW		= 3
} mixin ENUM_END_LIST!(BASEDRAW_HOOK_MESSAGE);

enum CINEMAINFO
{
	CINEMAINFO_TABLETT			 = 4,
	CINEMAINFO_OPENGL				 = 7,
	CINEMAINFO_TABLETT_HIRES = 8,
	CINEMAINFO_FORBID_GUI		 = 9,
	CINEMAINFO_FORBID_OGL		 = 10,
	CINEMAINFO_LISTEN				 = 11,
	CINEMAINFO_WATCH_PID		 = 12,
	CINEMAINFO_SETFOREGROUND = 13
} mixin ENUM_END_FLAGS!(CINEMAINFO);

//IpAddr
enum PROTOCOL
{
	PROTOCOL_ZERO = 0,
	PROTOCOL_IPV4	=	1000,
	PROTOCOL_IPV6
} mixin ENUM_END_LIST!(PROTOCOL);

enum PROXYTYPE
{
	PROXYTYPE_HTML,
	PROXYTYPE_SOCKS4,
	PROXYTYPE_SOCKS5
} mixin ENUM_END_LIST!(PROXYTYPE);

enum RESOLVERESULT
{
	RESOLVERESULT_OK				=0,
	RESOLVERESULT_RETRY			=2,	// temporary failure, a retry might succeed
	RESOLVERESULT_SETUP			=3,	// internal failure (should not happen though)
	RESOLVERESULT_UNKNOWN		=4,	// unknown error while resolving address
	RESOLVERESULT_ERRINT		=5,	// the interface family is not supported
	RESOLVERESULT_NONAME		=6,	// could not resolve request, no name found
	RESOLVERESULT_SERVICE		=7,	// internal failure (pServicename parameter not supported)
	RESOLVERESULT_SOCKETTYPE=8,	// internal failure (ai_socktype not supported)
	RESOLVERESULT_UNKNOWNINT=9	// could resolve name but not for the requested interface
} mixin ENUM_END_LIST!(RESOLVERESULT);

enum SERVERJOBLIST
{
	SERVERJOBLIST_INACTIVE=1000,
	SERVERJOBLIST_ACTIVE,
	SERVERJOBLIST_DOWNLOAD,
	SERVERJOBLIST_ALL
} mixin ENUM_END_LIST!(SERVERJOBLIST);

enum JOBCOMMAND
{
	JOBCOMMAND_NONE = 1000,	// do nothing
	JOBCOMMAND_FETCHJOB,
	JOBCOMMAND_ALLOCATESPACE,
	JOBCOMMAND_DOWNLOAD,
	JOBCOMMAND_RENDER,
	JOBCOMMAND_DELETE,
	JOBCOMMAND_STOPANDDELETE,
	JOBCOMMAND_ASSEMBLE,
	JOBCOMMAND_END
} mixin ENUM_END_LIST!(JOBCOMMAND);

enum RENDERTARGET						// BaseContainer ID
{
	RENDERTARGET_ALL = 1000,	// use all machines
	RENDERTARGET_SPECIFIED,		// uuids
	RENDERTARGET_MINMAX				// (1000;min) (1001;max)
} mixin ENUM_END_LIST!(RENDERTARGET);

enum JOBSTATE
{
	JOBSTATE_IDLE = 1000,

	// preparing only for server in async mode for StartRendering
	JOBSTATE_PREPARING_RUNNING,
	JOBSTATE_PREPARING_FAILED,
	JOBSTATE_PREPARING_OK,

	JOBSTATE_RENDER_RUNNING,
	JOBSTATE_RENDER_PAUSED,
	JOBSTATE_RENDER_OK,
	JOBSTATE_RENDER_FAILED,

	JOBSTATE_ALLOCATESPACE_RUNNING,
	JOBSTATE_ALLOCATESPACE_OK,
	JOBSTATE_ALLOCATESPACE_FAILED,

	JOBSTATE_DOWNLOAD_RUNNING,
	JOBSTATE_DOWNLOAD_OK,
	JOBSTATE_DOWNLOAD_FAILED,

	JOBSTATE_ASSEMBLE_RUNNING,
	JOBSTATE_ASSEMBLE_OK,
	JOBSTATE_ASSEMBLE_FAILED,

	JOBSTATE_STOPPED
} mixin ENUM_END_LIST!(JOBSTATE);

enum ZEROCONFMACHINESTATE
{
	ZEROCONFMACHINESTATE_ONLINE	 = 1,
	ZEROCONFMACHINESTATE_OFFLINE = 2,
	ZEROCONFMACHINESTATE_REMOVED = 3,
	ZEROCONFMACHINESTATE_UPDATE	 = 4,
} mixin ENUM_END_LIST!(ZEROCONFMACHINESTATE);

enum ZEROCONFACTION
{
	ZEROCONFACTION_0			 = 0,
	ZEROCONFACTION_RESOLVE = (1 << 0),
	ZEROCONFACTION_MONITOR = (1 << 1)
} mixin ENUM_END_FLAGS!(ZEROCONFACTION);

enum ZEROCONFERROR
{
	ZEROCONFERROR_NOERROR										= 0,
	ZEROCONFERROR_UNKNOWN										= -65537,	/* 0xFFFE FFFF */
	ZEROCONFERROR_NOSUCHNAME								= -65538,
	ZEROCONFERROR_NOMEMORY									= -65539,
	ZEROCONFERROR_BADPARAM									= -65540,
	ZEROCONFERROR_BADREFERENCE							= -65541,
	ZEROCONFERROR_BADSTATE									= -65542,
	ZEROCONFERROR_BADFLAGS									= -65543,
	ZEROCONFERROR_UNSUPPORTED								= -65544,
	ZEROCONFERROR_NOTINITIALIZED						= -65545,
	ZEROCONFERROR_ALREADYREGISTERED					= -65547,
	ZEROCONFERROR_NAMECONFLICT							= -65548,
	ZEROCONFERROR_INVALID										= -65549,
	ZEROCONFERROR_FIREWALL									= -65550,
	ZEROCONFERROR_INCOMPATIBLE							= -65551,	/* Client Library Incompatible with daemon */
	ZEROCONFERROR_BADINTERFACEINDEX					= -65552,
	ZEROCONFERROR_REFUSED										= -65553,
	ZEROCONFERROR_NOSUCHRECORD							= -65554,
	ZEROCONFERROR_NOAUTH										= -65555,
	ZEROCONFERROR_NOSUCHKEY									= -65556,
	ZEROCONFERROR_NATTRAVERSAL							= -65557,
	ZEROCONFERROR_DOUBLENAT									= -65558,
	ZEROCONFERROR_BADTIME										= -65559,	/* Codes up to here existed in Tiger */
	ZEROCONFERROR_BADSIG										= -65560,
	ZEROCONFERROR_BADKEY										= -65561,
	ZEROCONFERROR_TRANSIENT									= -65562,
	ZEROCONFERROR_SERVICENOTRUNNING					= -65563,	/* Background daemon not running */
	ZEROCONFERROR_NATPORTMAPPINGUNSUPPORTED = -65564,	/* NAT doesnt't support NAT_PMP or UPNP */
	ZEROCONFERROR_NATPORTMAPPINGDISABLED		= -65565,	/* NAT supports NAT-PMP or UPNP but it's disabled by the administrator */
	ZEROCONFERROR_NOROUTER									= -65566,	/* No router currently configured (probably no network connectivity) */
	ZEROCONFERROR_POLLINGMODE								= -65567
} mixin ENUM_END_LIST!(ZEROCONFERROR);

enum RENDERSETTING_STATICTAB_OUTPUT =			 1;
enum RENDERSETTING_STATICTAB_SAVE =				 2;
enum RENDERSETTING_STATICTAB_MULTIPASS =		 3;
enum RENDERSETTING_STATICTAB_ANTIALIASING = 4;
enum RENDERSETTING_STATICTAB_OPTIONS =			 5;
enum RENDERSETTING_STATICTAB_STEREO =			 6;
enum RENDERSETTING_STATICTAB_NET =					 7;


enum VIEWPORTSELECTFLAGS
{
	VIEWPORTSELECTFLAGS_0									= 0,
	VIEWPORTSELECTFLAGS_USE_HN						= 1,
	VIEWPORTSELECTFLAGS_USE_DEFORMERS			= 2,
	VIEWPORTSELECTFLAGS_REGION_SELECT			= 4,
	VIEWPORTSELECTFLAGS_IGNORE_HIDDEN_SEL	= 8,
	VIEWPORTSELECTFLAGS_USE_DISPLAY_MODE	= 16,
} mixin ENUM_END_FLAGS!(VIEWPORTSELECTFLAGS);

enum SCRIPTMODE
{
	SCRIPTMODE_NONE												= 0,
	SCRIPTMODE_PYTHON											= 1,
	SCRIPTMODE_COFFEE											= 2
} mixin ENUM_END_LIST!(SCRIPTMODE);
// function tables

//GLSL 

alias	uint C4DGLuint;
alias	int C4DGLint;

enum GlVertexBufferSubBufferType { VBArrayBuffer = 0, VBElementArrayBuffer = 1 };

enum GlVertexBufferAccessFlags { VBReadWrite = 0, VBReadOnly = 1, VBWriteOnly = 2 };