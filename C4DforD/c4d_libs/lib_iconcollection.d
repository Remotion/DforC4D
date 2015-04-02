

module lib_iconcollection;

import c4d_library;


enum ICONFLAG
{
	ICONFLAG_0			= 0,
	ICONFLAG_COPY		= (1 << 0),
	ICONFLAG_OVERWRITE	= (1 << 1),
	ICONFLAG_2X			= (1 << 2)
} mixin ENUM_END_FLAGS!(ICONFLAG);


enum LIBRARY_ICON_COLLECTION =    1009310;

extern(C++) //! important 
struct IconCollectionLib //: public C4DLibrary
{
	C4DLibrary parent; //?
	alias parent this; //? 

	Bool        function(Int32 lIconID, BaseBitmap *pBmp, Int32 x, Int32 y, Int32 w, Int32 h, ICONFLAG lFlags) RegisterIconBitmap;
	Bool        function(Int32 lIconID, Filename fn, Int32 x, Int32 y, Int32 w, Int32 h, ICONFLAG lFlags) RegisterIconFile;
	Bool        function(Int32 lIconID, IconData* pData) GetIcon;
	Bool        function(Int32 lIconID) UnregisterIcon;
};

//pragma(msg, IconCollectionLib.RegisterIconBitmap.offsetof );
//pragma(msg, IconCollectionLib.RegisterIconFile.offsetof );
//pragma(msg, IconCollectionLib.GetIcon.offsetof );
//pragma(msg, IconCollectionLib.UnregisterIcon.offsetof );

alias LIBID		= LIBRARY_ICON_COLLECTION;
alias LIB		= IconCollectionLib;


static assert(C4DLibrary.sizeof == 8);
static assert(IconCollectionLib.sizeof == 40);

static assert(LIBOFFSET!(LIB.RegisterIconBitmap) == 8);
static assert(LIBOFFSET!(IconCollectionLib.RegisterIconBitmap) == 8);

//static assert(LIBOFFSET!(LIB,RegisterIconBitmap) == 8);

static assert(LIBOFFSET!(IconCollectionLib.RegisterIconFile)  == 16);
static assert(LIBOFFSET!(IconCollectionLib.GetIcon)  == 24);
static assert(LIBOFFSET!(IconCollectionLib.UnregisterIcon)  == 32);

static __gshared LIB *library = null;

//extern(C++)
static LIB *CheckLibObjectList(Int32 offset)
{
	return cast(LIB*)CheckLib(LIBID, offset, cast(C4DLibrary**)&library);
}


Bool RegisterIcon(Int32 lIconID, BaseBitmap * pBmp, Int32 x, Int32 y, Int32 w, Int32 h, ICONFLAG lFlags)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.RegisterIconBitmap)); if (!lib || !lib.RegisterIconBitmap) return -1;
	return lib.RegisterIconBitmap(lIconID, pBmp, x, y, w, h, lFlags);
}

Bool RegisterIcon(Int32 lIconID, Filename fn, Int32 x, Int32 y, Int32 w, Int32 h, ICONFLAG lFlags)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.RegisterIconFile)); if (!lib || !lib.RegisterIconFile) return -1;
	return lib.RegisterIconFile(lIconID, fn, x, y, w, h, lFlags);
}
//extern(C++)
Bool GetIcon(Int32 lIconID, IconData* pData)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetIcon)); if (!lib || !lib.GetIcon) return false;
	return lib.GetIcon(lIconID, pData);
}

Bool UnregisterIcon(Int32 lIconID)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.UnregisterIcon)); if (!lib || !lib.UnregisterIcon) return false;
	return lib.UnregisterIcon(lIconID);
}
