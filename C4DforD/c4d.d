
//Remotion c4d for D module >>>

module c4d;

public import re_meta; 


enum API_VERSION = 14000;
//enum API_VERSION	    = 15800;


enum C4DPL_VERSION		= 0x0005;
enum __FLOAT_32_BIT		= false;

version (X86_64) {
	enum MAXON_TARGET_64BIT = 1;
}

version (Windows){
	enum __PC = 1;
} else {
	enum __PC = 0;
}
version (OSX){
	enum __MAC = 1;
} else {
	enum __MAC = 0;
}


static if(__VERSION__ < 2066) { enum nogc = 1; }

// c4d_main errors
enum {
	C4DPL_ERROR			= -1,
	C4DPL_ERROR_TYPE	= -2,
	C4DPL_ERROR_VERSION	= -3,
	C4DPL_ERROR_OS		= -4,
	C4DPL_ERROR_MEM		= -5,
};


// c4d_main action
enum {
	C4DPL_INIT_SYS		= 1,
	C4DPL_INIT			= 2,	//PluginStart();
	C4DPL_END			= 3,	//PluginEnd();  FreeResource();  ...
	C4DPL_INIT_VERSION	= 4,	//should return 5 ???
	C4DPL_MESSAGE		= 6,	//PluginMessage((VLONG)id,data)
};

// messages
enum {
	C4DMSG_PRIORITY				=	0,

	C4DPL_STARTACTIVITY			=	1000,
	C4DPL_ENDACTIVITY			=	1001,
	C4DPL_ENDPLUGINACTIVITY0	=	1026848,
	C4DPL_ENDPLUGINACTIVITY1	=	200000272,
	C4DPL_ENDPLUGINACTIVITY2	=	200000276,
	C4DPL_RELOADPYTHONPLUGINS	=	1026963,
	C4DPL_COMMANDLINEARGS		=	1002,
	C4DPL_EDITIMAGE				=   1003,

	C4DPL_BUILDMENU				=   1001188,
};

/*
typedef Char			CHAR;
typedef UChar			UCHAR;
typedef Int16			SWORD;
typedef UInt16			UWORD;

//typedef Int32			LONG;	//conflict with winnt.h
//typedef UInt32		ULONG;	//conflict with winnt.h

typedef Int64			LLONG;
typedef UInt64			LULONG;
typedef Int				VLONG;
typedef UInt			VULONG;

*/

//alias null		nullptr;



// http://dlang.org/type.html
alias int		 Bool; //C4D Bool is and int32 ?????
enum TRUE  = cast(Bool)true; //TODO 
enum FALSE = cast(Bool)false;  //TODO


alias char		 Char;		///< UTF-8 code unit  unsigned 

//todo >>>
alias ubyte		UChar;	///< unsigned 8 bit character
alias wchar		 Char16;	///< UTF-16 code unit unsigned 
alias dchar		 Char32;	///< UTF-32 code unit unsigned 

alias byte		 Int8;
alias ubyte		UInt8;

alias short		 Int16;
alias ushort	UInt16;

alias int		 Int32;
alias uint		UInt32;

alias long		 Int64;
alias ulong		UInt64;

alias float		Float32;	///< 32 bit floating point value (float)
alias double	Float64;	///< 64 bit floating point value (double)
alias Float64	Float;

version (X86_64) {
	alias Int64				Int;
	alias UInt64			UInt;
}else version (X86){
	alias Int32				Int;		///< signed 32/64 bit int, size depends on the platform
	alias UInt32			UInt;		///< unsigned 32/64 bit int, size depends on the platform
}

static assert(Int.sizeof==(void*).sizeof);
static assert(UInt.sizeof==(void*).sizeof);


static assert(bool.sizeof==1);

static assert(Char.sizeof==1);

static assert(Int8.sizeof==1);
static assert(UInt8.sizeof==1);

static assert(Int16.sizeof==2);
static assert(UInt16.sizeof==2);

static assert(Int32.sizeof==4);
static assert(UInt32.sizeof==4);

static assert(Int64.sizeof==8);
static assert(UInt64.sizeof==8);

static assert(Float32.sizeof==4);
static assert(Float64.sizeof==8);

/*
struct C4D_General			;
struct C4D_Shader			;
struct C4D_HyperFile		;	
struct C4D_BaseContainer	;	
struct C4D_String			;
struct C4D_Bitmap			;
struct C4D_MovieSaver		;
struct C4D_BaseChannel		;
struct C4D_Filename			;
struct C4D_File				;
struct C4D_BrowseFiles		;
struct C4D_Dialog			;
struct C4D_UserArea			;
struct C4D_Parser			;
struct C4D_Resource			;
struct C4D_BaseList			;
struct C4D_Tag				;
struct C4D_Object			;
struct C4D_Document			;
struct C4D_Thread			;
struct C4D_Material			;
struct C4D_Texture			;
struct C4D_BaseSelect		;
struct C4D_BaseSound		;	
struct C4D_BaseDraw			;
struct C4D_BaseView			;
struct C4D_Neighbor			;
struct C4D_Pool				;
struct C4D_BitmapFilter		;
struct C4D_Painter			;
struct C4D_Link				;
struct C4D_GraphView		;	
struct C4D_GeData			;
struct C4D_Atom				;
struct C4D_Coffee			;
struct C4D_CAnimation		;
*/