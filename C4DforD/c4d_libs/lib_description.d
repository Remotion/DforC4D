

module lib_description;

//import c4d_os;
import c4d_library;

import c4d_baselist :/* C4DAtom,C4DAtomGoal,GeListNode,*/BaseList2D;
//struct BaseList2D;
struct SubDialog;
struct BCResourceObj;
struct DescEntry;
struct DescriptionCustomGui;
//struct AtomArray;

//alias DESCID_ROOT =					DescID(DescLevel(1000491, 0, 0));
//alias DESCID_DYNAMICSUB =				DescLevel(ID_USERDATA, DTYPE_SUBCONTAINER, 0);

enum ID_USERDATA =						700;
enum BOOL_PAGEMODE =					C4D_FOUR_BYTE("bpmd");


// defines for description
enum
{
	DTYPE_NONE					= 0,

	DTYPE_CHILDREN			= 0,
	DTYPE_GROUP					= 1,
	DTYPE_COLOR					= 3,
	DTYPE_SUBCONTAINER  = 5,	// subcontainer data
	DTYPE_MULTIPLEDATA  = 6,	// multiple data entry
	DTYPE_TEXTURE				= 7,	// String: Texturename
	DTYPE_BUTTON				= 8,
	DTYPE_DYNAMIC				= 10, // for graphview "DYNAMIC"
	DTYPE_SEPARATOR			= 11, //
	DTYPE_STATICTEXT		= 12, //
	DTYPE_POPUP         = 13,

	DTYPE_LONG					= 15,
	DTYPE_REAL					= 19,
	DTYPE_TIME					= 22,
	DTYPE_VECTOR				= 23,
	DTYPE_MATRIX				= 25,
	DTYPE_STRING				= 130,
	DTYPE_FILENAME			= 131, // DA_FILENAME
	DTYPE_BASELISTLINK	= 133,
	DTYPE_BOOL					= 400006001,//ID_GV_DATA_TYPE_BOOL
	DTYPE_NORMAL				= 400006005,//ID_GV_DATA_TYPE_NORMAL

	//--------------------
	DESC_NAME						= 1,					// name for parameter standalone use
	DESC_SHORT_NAME			= 2,					// short name (only for attribute dialog)

	DESC_VERSION				= 3,					// Int32: bitmask of the following values DESC_VERSION_xxx
	DESC_VERSION_DEMO		= (1 << 0),
	DESC_VERSION_XL			= (1 << 1),
	DESC_VERSION_ALL		= DESC_VERSION_DEMO|DESC_VERSION_XL,
	DESC_CHILDREN				= 4,					// BaseContainer
	DESC_MIN						= 5,					// Int32/Float/Vector minimum INcluded
	DESC_MAX						= 6,					// Int32/Float/Vector maximum INcluded
	DESC_MINEX					= 7,					// Bool: true == minimum EXcluded
	DESC_MAXEX					= 8,					// Bool: true == maximum EXcluded
	DESC_STEP						= 9,					// Int32/Float/Vector
	DESC_ANIMATE				= 10,					// Int32
	DESC_ANIMATE_OFF			= 0,
	DESC_ANIMATE_ON				= 1,
	DESC_ANIMATE_MIX			= 2,
	DESC_ASKOBJECT				= 11,					// Bool: true - ask object for this parameter, false - look inside container
	DESC_UNIT					= 12,					// Int32: one of the following values DESC_UNIT_xxx for DTYPE_REAL/DTYPE_VECTOR
	DESC_UNIT_FLOAT			= C4D_FOUR_BYTE("frea"),		//FORMAT_FLOAT,
	DESC_UNIT_INT			= C4D_FOUR_BYTE("flng"),		//FORMAT_INT,
	DESC_UNIT_PERCENT		= C4D_FOUR_BYTE("fpct"),		//FORMAT_PERCENT,
	DESC_UNIT_DEGREE		= C4D_FOUR_BYTE("fdgr"),		//FORMAT_DEGREE,
	DESC_UNIT_METER			= C4D_FOUR_BYTE("fmet"),		//FORMAT_METER,
	DESC_UNIT_TIME			= C4D_FOUR_BYTE("ffrm"),		//FORMAT_FRAMES,
	DESC_PARENTGROUP			= 13,					// Int32/DescID: parent id
	DESC_CYCLE					= 14,					// Container: members of cycle
	DESC_HIDE					= 15,					// Bool: indicates whether the property is hidden or not
	DESC_DEFAULT				= 16,					// default value for Int32/Float/Vector:
	DESC_ACCEPT					= 17,					// ACCEPT: for InstanceOf-Check()
	DESC_SEPARATORLINE			= 18,
	DESC_REFUSE					= 19,					// REFUSE: for InstanceOf-Check()
	DESC_PARENTID				= 20,					// for indent and anim track can append the parent-name
	DESC_CUSTOMGUI				= 21,					// customgui for this property


	DESC_COLUMNS					= 22,					// DTYPE_GROUP: number of columns
	DESC_LAYOUTGROUP			= 23,					// Bool: only for layout in columns, in layout groups are only groups allowed!
	DESC_REMOVEABLE				= 24,					// Bool: true allows to remove this entry
	DESC_GUIOPEN					= 25,					// Bool: default open
	DESC_EDITABLE					= 26,					// Bool: true allows to edit this entry
	DESC_MINSLIDER				= 27,					// Int32/Float/Vector minimum INcluded
	DESC_MAXSLIDER				= 28,					// Int32/Float/Vector maximum INcluded
	DESC_GROUPSCALEV			= 29,					// Bool: allow to scale group height
	DESC_SCALEH						= 30,					// Bool: scale element horizontal
	DESC_LAYOUTVERSION		= 31,					// Int32: layout version
	DESC_ALIGNLEFT				= 32,					// Bool: align element left
	DESC_FITH							= 33,					// Bool: fit element
	DESC_NEWLINE        	= 34,					// Bool: line break
	DESC_TITLEBAR					= 35,					// Bool: main group title bar
	DESC_CYCLEICONS				= 36,					// Container: Int32 icon ids for cycle
	DESC_CYCLESYMBOLS			= 37,					// Container: String identifiers for help symbol export
	DESC_PARENT_COLLAPSE	= 38,					// parent collapse id
	DESC_FORBID_INLINE_FOLDING = 39,		// Bool: instruct AM not to allow expanding inline objects for this property
	DESC_FORBID_SCALING		= 40,					// Bool: prevent auto scaling of the parameter with the scale tool (for DESC_UNIT_METER)
	DESC_ANGULAR_XYZ			= 41,					// Bool: angular representation as XYZ vs. HPB

	// port extension for graphview
	DESC_INPORT					= 50,
	DESC_OUTPORT				= 51,
	DESC_STATICPORT			= 52,
	DESC_NEEDCONNECTION	= 53,
	DESC_MULTIPLE				= 54,
	DESC_PORTONLY				= 55,
	DESC_CREATEPORT			= 56,
	DESC_PORTSMIN				= 57,
	DESC_PORTSMAX				= 58,
	DESC_NOTMOVABLE			= 59,
	DESC_EDITPORT				= 60,
	DESC_ITERATOR				= 61,

	DESC_PARENTMSG			= 62,
	DESC_MATEDNOTEXT		= 63,
	DESC_COLUMNSMATED		= 64,					// DESC_COLUMNSMATED: number of columns in left mated window
	DESC_SHADERLINKFLAG	= 65,					// only if (datatype==DTYPE_LINK) to specify if shader
	DESC_NOGUISWITCH		= 66,

	DESC_TEMPDESCID			= 998,				// used internally to store the preferred descid
	DESC_IDENT					= 999,
	DESC_
};

alias CUSTOMGUI_REAL			= DTYPE_REAL;
enum CUSTOMGUI_REALSLIDER		= 1000489;
enum CUSTOMGUI_REALSLIDERONLY	= 200000006;
alias CUSTOMGUI_VECTOR			= DTYPE_VECTOR;
alias CUSTOMGUI_STRING			= DTYPE_STRING;
enum CUSTOMGUI_STRINGMULTI		= 200000007;
alias CUSTOMGUI_STATICTEXT		= DTYPE_STATICTEXT;
enum CUSTOMGUI_CYCLE			= 200000180;
enum CUSTOMGUI_CYCLEBUTTON		= 200000255;
alias CUSTOMGUI_LONG			= DTYPE_LONG;
enum CUSTOMGUI_LONGSLIDER		= 1000490;
alias CUSTOMGUI_BOOL			= DTYPE_BOOL;
alias CUSTOMGUI_TIME			= DTYPE_TIME;
enum CUSTOMGUI_COLOR			= 1000492;
alias CUSTOMGUI_MATRIX			= DTYPE_MATRIX;
alias CUSTOMGUI_BUTTON			= DTYPE_BUTTON;
alias CUSTOMGUI_POPUP			= DTYPE_POPUP;
alias CUSTOMGUI_SEPARATOR		= DTYPE_SEPARATOR;
enum CUSTOMGUI_SUBDESCRIPTION	= 0;
enum CUSTOMGUI_PROGRESSBAR		= 200000265;


enum CUSTOMDATATYPE_DESCID =		1000486;

enum
{
	VECTOR_X		= 1000,
	VECTOR_Y		= 1001,
	VECTOR_Z		= 1002
};

enum
{
	COLOR_R			= 1000,
	COLOR_G			= 1001,
	COLOR_B			= 1002
};

//=============================================================================
struct DescLevel
{
	Int32	id = 0;
	Int32	dtype   = 0;
	Int32	creator = 0;

	this(Int32 t_id) { id=(t_id); dtype=(0); creator=(0); }
	this(Int32 t_id, Int32 t_datatype, Int32 t_creator) { id=(t_id); dtype=(t_datatype); creator=(t_creator);  }

	//Bool operator == (const DescLevel &d) const;
	//Bool operator != (const DescLevel &d) const;

	// operator ==,  operator !=
	bool opEquals(in DescLevel d) const  {
		if (d.id != id) return false;
		// special case!
		if (d.dtype == 0 && d.id == 0 && d.creator == 0) return (dtype == 0 && id == 0 && creator == 0);
		else if (dtype == 0 && id == 0 && creator == 0) return (d.dtype == 0 && d.id == 0 && d.creator == 0);
		if (d.dtype && dtype && d.dtype != dtype) return false;
		if (d.creator && creator && d.creator != creator) return false;
		return true;
	}

};

//=============================================================================
struct DescID //: public iCustomDataType<DescID> // iCustomDataType is okay here since the size is the same
{
		Int32  temp1 = 0;
		Int32 *temp2 = null;

	public:
		//static DescID* Alloc() { return NewObjClear(DescID); }
		//static void Free(ref DescID* data) { DeleteObj(data); }

		
		this(_INITTCONSTRUCT ic)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
		}

		this(ref const DescID  src)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
			//*this = src;
			temp1 = src.temp1;
			temp2 = cast(Int32*)src.temp2;
		}

		static DescID opCall(in DescLevel id1)	{
			DescID n = DescID(id1);
			return n;
		}
		this(in DescLevel id1)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
			SetId(id1);
		}

		this(Int32 id1)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
			SetId(DescLevel(id1));
		}

		this(ref const DescLevel  id1, ref const DescLevel  id2)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
			SetId(id1);
			PushId(id2);
		}

		this(ref const DescLevel  id1, ref const DescLevel  id2, ref const DescLevel  id3)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Init)); if (!lib || !lib.DescID_Init) return;
			lib.DescID_Init(&this);
			SetId(id1);
			PushId(id2);
			PushId(id3);
		}

		~this()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Free)); if (!lib || !lib.DescID_Free) return;
			lib.DescID_Free(&this);
		}

		void SetId(/*ref const*/in DescLevel  subid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_SetId)); if (!lib || !lib.DescID_SetId) return;
			lib.DescID_SetId(&this, subid);
		}

		void PushId(ref const DescLevel  subid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_PushId)); if (!lib || !lib.DescID_PushId) return;
			lib.DescID_PushId(&this, subid);
		}

		void PopId()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_PopId)); if (!lib || !lib.DescID_PopId) return;
			lib.DescID_PopId(&this);
		}

		Bool Read(HyperFile *hf)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Read)); if (!lib || !lib.DescID_Read) return false;
			return lib.DescID_Read(&this, hf);
		}

		Bool Write(HyperFile *hf)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Read)); if (!lib || !lib.DescID_Write) return false;
			return lib.DescID_Write(&this, hf);
		}

		Int32 GetDepth() const {
			Int32 i = 0;
			for (; this[i].id != 0; i++) { }
			return i;
		}

		// checks if 'this' is part of 'cmp'
		Bool IsPartOf(ref const DescID  cmp, Int32 *pos) const	{
			Int32 i;
			for (i = 0; this[i].id != 0; i++) {
				// ITEM#37542 MAXON Bug-Report V11.514 [mac], comparing only the id without the type caused a crash in animation.
				if ( this[i] != cmp[i])	break;
			}
			if (pos) *pos = i;
			return i > 0 &&  this[i].id == 0;
		}

		
		//Bool operator == (const DescID &d) const;
		//Bool operator != (const DescID &d) const;
		bool opEquals(in DescID d) const  {
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Compare)); if (!lib || !lib.DescID_Compare) return 0;
			return cast(bool)lib.DescID_Compare(cast(DescID*)&d, cast(DescID*)&this);
		}


		//const DescLevel &operator[] (Int32 pos) const;
		ref const(DescLevel) opIndex(Int32 pos) const {
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_operator1)); if (!lib || !lib.DescID_operator1) return fallbacklevel;
			return lib.DescID_operator1(cast(DescID*)&this, pos);
		}

		//const DescID& operator = (const DescID &id);
		ref const(DescID) opAssign()(auto ref DescID id)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_CopyTo)); if (!lib || !lib.DescID_CopyTo) return this;
			lib.DescID_CopyTo(cast(DescID*)&id, cast(DescID*)&this);
			return this;
		}

		ref const(DescID) opAssign()(auto ref DescLevel dl)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_CopyTo)); if (!lib || !lib.DescID_CopyTo) return this;
			const DescID id = DescID(dl);
			lib.DescID_CopyTo(cast(DescID*)&id, cast(DescID*)&this);
			return this;
		}
		//const DescID operator <<(Int32 shift) const;
		/+ //TODO 
		const DescID DescID::operator<< (Int32 shift) const
		{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_operator2)); if (!lib || !lib.DescID_operator2) return fallbacklevel;
			return lib.DescID_operator2((DescID*)this, shift);
		}
		+/

		//const DescID & operator += (const DescID &s);
		ref const(DescID) opOpAssign(string op) (auto ref const DescID s) {
			static if (op == "+") { //+=
				LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_AddTo)); if (!lib || !lib.DescID_AddTo) return *this;
				lib.DescID_AddTo(cast(DescID*)&this, cast(DescID*)&s);
				return *this;
			}
			else static assert(0, "Operator "~op~" not implemented");
		}
		//friend const DescID operator + (const DescID &v1, const DescID &v2);

};

DescLevel fallbacklevel = (0); ///???

/+
const DescID operator+(const DescID &v1, const DescID &v2)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescID_Add)); if (!lib || !lib.DescID_Add) return v1;
	return lib.DescID_Add((DescID*)&v1, (DescID*)&v2);
}
+/

//=============================================================================
struct Description
{
	private:
		@disable this(); //Description();
		//~Description();

	public:
		/+
		static Description *Alloc();
		static void Free(Description *&description);

		Bool LoadDescription(const BCResourceObj *bc, Bool copy);
		Bool LoadDescription(Int32 id);
		Bool LoadDescription(const String &id);
		Bool SortGroups();

		const BCResourceObj* GetDescription();														// returns the complete description
		const BaseContainer* GetParameter(const DescID &id, BaseContainer &temp, AtomArray *ar) const;							// returns the specified property
		BaseContainer* GetParameterI(const DescID &id, AtomArray *ar);										// returns the specified property
		Bool SetParameter(const DescID &id, const BaseContainer &param, const DescID &groupid);		// returns the specified property

		void *BrowseInit();																								// browse property start, dont forget to call xxxFree
		Bool GetNext(void *handle, const BaseContainer **bc, DescID &id, DescID &groupid);					// returns all properties sequently
		void BrowseFree(void *&handle);																		// browse property free

		DescEntry *GetFirst(const AtomArray &op);
		DescEntry *GetNext(DescEntry *de);
		DescEntry *GetDown(DescEntry *de);
		void GetDescEntry(DescEntry *de, const BaseContainer **bc, DescID &descid);

		SubDialog *CreateDialogI();
		void FreeDialog(SubDialog *dlg);

		Bool CreatePopupMenu(BaseContainer &menu);
		Bool GetPopupId(Int32 id, const DescID &descid);

		Bool CheckDescID(const DescID &searchid, const AtomArray &ops, DescID *completeid);
		Bool GetSubDescriptionWithData(const DescID &did, const AtomArray &op, RESOURCEDATATYPEPLUGIN  *resdatatypeplugin, const BaseContainer &bc, DescID *singledescid);

		const DescID *GetSingleDescID();
		void SetSingleDescriptionMode(const DescID &descid);
		+/

		Description *Alloc()
		{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.Alloc)); if (!lib || !lib.Alloc) return nullptr;
			return lib.Alloc();
		}

		void Free(ref Description *description)	{
			if (!description) return;
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.Free)); if (!lib || !lib.Free) return;
			lib.Free(description);
			description = nullptr;
		}

		Bool LoadDescription(const BCResourceObj *bc, Bool copy) {
			if (!bc) return false;
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.LoadDescriptionBc)); if (!lib || !lib.LoadDescriptionBc) return false;
			return lib.LoadDescriptionBc(&this, bc, copy);
		}

		Bool LoadDescription(Int32 id) {
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.LoadDescriptionId)); if (!lib || !lib.LoadDescriptionId) return false;
			return lib.LoadDescriptionId(&this, id);
		}

		Bool LoadDescription(ref const String id) {
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.LoadDescriptionStr)); if (!lib || !lib.LoadDescriptionStr) return false;
			return lib.LoadDescriptionStr(&this, &id);
		}

		Bool SortGroups()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.SortGroups)); if (!lib || !lib.SortGroups) return false;
			return lib.SortGroups(&this);
		}

		BCResourceObj* GetDescription()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetDescription)); if (!lib || !lib.GetDescription) return nullptr;
			return lib.GetDescription(&this);
		}

		BaseContainer* GetParameter(ref const DescID id,ref BaseContainer temp, AtomArray *ar) const	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetParameter)); if (!lib || !lib.GetParameter) return nullptr;
			return lib.GetParameter(&this, id, temp, ar);
		}

		BaseContainer* GetParameterI(ref const DescID id, AtomArray *ar)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetParameterI)); if (!lib || !lib.GetParameterI) return nullptr;
			return lib.GetParameterI(&this, id, ar);
		}

		Bool SetParameter(ref const DescID id,ref const BaseContainer param,ref const DescID groupid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetParameter)); if (!lib || !lib.SetParameter) return false;
			return lib.SetParameter(&this, id, param, groupid);
		}

		void *BrowseInit()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.BrowseInit)); if (!lib || !lib.BrowseInit) return nullptr;
			return lib.BrowseInit(&this);
		}

		Bool GetNext(void *handle, const BaseContainer **bc,ref DescID id,ref DescID groupid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetNext)); if (!lib || !lib.GetNext) return false;
			return lib.GetNext(&this, handle, bc, id, groupid);
		}

		void BrowseFree(ref void *handle)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.BrowseFree)); if (!lib || !lib.BrowseFree) return;
			lib.BrowseFree(&this, handle);
		}

		SubDialog *CreateDialogI()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.CreateDialogI)); if (!lib || !lib.CreateDialogI) return nullptr;
			return lib.CreateDialogI(&this);
		}

		void FreeDialog(SubDialog *dlg)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.FreeDialog)); if (!lib) return;
			lib.FreeDialog(&this, dlg);
		}

		Bool CreatePopupMenu(ref BaseContainer menu)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.CreatePopupMenu)); if (!lib) return false;
			return lib.CreatePopupMenu(&this, &menu);
		}

		Bool GetPopupId(Int32 id,ref const DescID descid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetPopupId)); if (!lib) return false;
			return lib.GetPopupId(&this, id, descid);
		}

		const DescID* GetSingleDescID()	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetSingleDescID)); if (!lib) return nullptr;
			return lib.GetSingleDescID(&this);
		}

		void SetSingleDescriptionMode(ref const DescID descid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.SetSingleDescriptionMode)); if (!lib) return;
			lib.SetSingleDescriptionMode(&this, descid);
		}
		/+
		///unknow sizeof(AtomArray) problem >>>
		Bool GetSubDescriptionWithData(ref const DescID did,ref const AtomArray op, RESOURCEDATATYPEPLUGIN *resdatatypeplugin,ref const BaseContainer bc, DescID *singledescid)		{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetSubDescriptionWithData)); if (!lib) return false;
			return lib.GetSubDescriptionWithData(&this, did, op, resdatatypeplugin, bc, singledescid);
		}

		Bool CheckDescID(ref const DescID searchid,ref const AtomArray ops, DescID *completeid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.CheckDescID)); if (!lib) return false;
			return lib.CheckDescID(&this, searchid, ops, completeid);
		}

		DescEntry* GetFirst(ref const AtomArray op)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescEntryGetFirst)); if (!lib) return nullptr;
			return lib.DescEntryGetFirst(&this, op);
		}
		+/

		DescEntry* GetNext(DescEntry *de)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescEntryGetNext)); if (!lib) return nullptr;
			return lib.DescEntryGetNext(&this, de);
		}

		DescEntry* GetDown(DescEntry *de)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescEntryGetDown)); if (!lib) return nullptr;
			return lib.DescEntryGetDown(&this, de);
		}

		void GetDescEntry(DescEntry *de, const BaseContainer **bc,ref DescID descid)	{
			LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescEntryGetDescEntry)); if (!lib) return;
			lib.DescEntryGetDescEntry(&this, de, bc, descid);
		}


};

String DescGenerateTitle(AtomArray *arr){
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DescEntryGetDescEntry)); if (!lib) return String();
	return lib.DescGenerateTitle(arr);
}


//=============================================================================
struct DynamicDescription
{
	@disable this(); //DynamicDescription();
	//~DynamicDescription();
public:
	/+
	DescID					Alloc(const BaseContainer &datadescription);
	Bool					Set(const DescID &descid, const BaseContainer &datadescription, BaseList2D *bl);
	const BaseContainer*	Find(const DescID &descid);
	Bool					Remove(const DescID &descid);

	Bool					CopyTo(DynamicDescription *dest);

	void*					BrowseInit(void);
	Bool					BrowseGetNext(void* handle, DescID *id, const BaseContainer **data);
	void					BrowseFree(void* &handle);

	Bool					FillDefaultContainer(BaseContainer &res, Int32 type, const String &name);

	UInt32					GetDirty() const;
	+/

	DescID Alloc(ref const BaseContainer datadescription)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDAlloc)); if (!lib || !lib.DDAlloc) return DescID(DescLevel(0));
		return lib.DDAlloc(&this,datadescription);
	}

	Bool Set(ref const DescID descid,ref const BaseContainer datadescription, BaseList2D *bl)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDSet)); if (!lib || !lib.DDSet) return false;
		return lib.DDSet(&this,descid, datadescription, bl);
	}

	const BaseContainer* Find(ref const DescID descid)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDFind)); if (!lib || !lib.DDFind) return nullptr;
		return lib.DDFind(&this,descid);
	}

	Bool Remove(ref const DescID descid)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDRemove)); if (!lib || !lib.DDRemove) return false;
		return lib.DDRemove(&this,descid);
	}

	Bool CopyTo(DynamicDescription *dest)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDCopyTo)); if (!lib || !lib.DDCopyTo) return false;
		return lib.DDCopyTo(&this,dest);
	}

	void* BrowseInit()	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDBrowseInit)); if (!lib || !lib.DDBrowseInit) return nullptr;
		return lib.DDBrowseInit(&this);
	}

	Bool BrowseGetNext(void* handle, DescID *id, const BaseContainer **data)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDBrowseGetNext)); if (!lib || !lib.DDBrowseGetNext) return false;
		return lib.DDBrowseGetNext(&this,handle, id, data);
	}

	void BrowseFree(ref void* handle)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.DDBrowseFree)); if (!lib || !lib.DDBrowseFree) return;
		lib.DDBrowseFree(&this,handle);
	}

	Bool FillDefaultContainer(ref BaseContainer res, Int32 type,ref const String name)	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.FillDefaultContainer)); if (!lib || !lib.FillDefaultContainer) return false;
		return lib.FillDefaultContainer(&this,res, type, name);
	}

	UInt32 GetDirty() const	{
		LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.GetDirty)); if (!lib || !lib.GetDirty) return 0;
		const UInt32 dirty = lib.GetDirty(&this);
		return dirty;
	}
};



// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF

enum LIBRARY_DESCRIPTIONLIB =	1000467;


extern(C++) //! important 
struct DescriptionLib //: public C4DLibrary
{
	C4DLibrary parent; //?
	alias parent this; //? 


	Bool                     function(Int32 id, ref const String  idstr, LocalResource *res)Register;

	Description*			 function()Alloc;
	void					 function(ref Description * description)Free;

	Bool					 function(Description *desc, const BCResourceObj *bc, Bool copy)LoadDescriptionBc;
	Bool					 function(Description *desc, Int32 id)LoadDescriptionId;
	Bool					 function(Description *desc, const String *id)LoadDescriptionStr;
	Bool					 function(Description *desc)SortGroups;

	const BCResourceObj*	 function(const Description *desc)GetDescription;
	const BaseContainer*	 function(const Description *desc, ref const DescID  id, ref BaseContainer  temp, AtomArray *ar)GetParameter;
	BaseContainer*			 function(Description *desc, ref const DescID  id, AtomArray *ar)GetParameterI;
	Bool					 function(Description *desc, ref const DescID  id, ref const BaseContainer  param, ref const DescID  groupid)SetParameter;	// returns the specified property

	void *					 function(Description *desc)BrowseInit;
	Bool					 function(Description *desc, void *handle, const BaseContainer **bc, ref DescID  id, ref DescID  groupid)GetNext;
	void					 function(Description *desc, ref void * handle)BrowseFree;
	void					 function(Description *desc)EX_01;

	SubDialog *				 function(Description *desc)CreateDialogI;
	void					 function(Description *desc, SubDialog *dlg)FreeDialog;

	Bool					 function(Description *desc, BaseContainer *menu)CreatePopupMenu;
	Bool					 function(Description *desc, Int32 id, ref const DescID  descid)GetPopupId;

	const DescID*			 function(const Description *desc)GetSingleDescID;
	void					 function(Description *desc, ref const DescID  descid)SetSingleDescriptionMode;

	void					 function(DescID *id) DescID_Init;
	void					 function(DescID *id) DescID_Free;
	void					 function(DescID *id, ref const DescLevel  subid) DescID_SetId;
	void					 function(DescID *id, ref const DescLevel  subid) DescID_PushId;
	void					 function(DescID *id) DescID_PopId;
	//ref const DescLevel 	 function(DescID *id, Int32 pos) DescID_operator1;
	alias ref const DescLevel 	 function(DescID *id, Int32 pos) DescID_operator1FT;	DescID_operator1FT	 DescID_operator1;
	
	const DescID			 function(DescID *id, Int32 pos) DescID_operator2; //TODO  bigger as 8 bytes ???
	void					 function(DescID *src, DescID *dest) DescID_CopyTo;
	Bool					 function(DescID *d1, DescID *d2) DescID_Compare;

	DescID					 function(DynamicDescription* self, ref const BaseContainer datadescription) DDAlloc; //TODO  bigger as 8 bytes !!!
	//void 					 function(DynamicDescription* self, DescID *result, ref const BaseContainer  datadescription) DDAlloc;
	
	Bool					 function(DynamicDescription* self, ref const DescID  descid, ref const BaseContainer  datadescription) DDSetObsolete;
	const BaseContainer*	 function(const DynamicDescription* self, ref const DescID  descid) DDFind;
	Bool					 function(DynamicDescription* self, ref const DescID  descid) DDRemove;
	Bool					 function(const DynamicDescription* self, DynamicDescription *dest) DDCopyTo ;
	void *					 function(const DynamicDescription* self) DDBrowseInit ;
	Bool					 function(const DynamicDescription* self, void * handle, DescID *id, const BaseContainer **data) DDBrowseGetNext ;
	void					 function(const DynamicDescription* self, ref void *  handle) DDBrowseFree ;
	Bool					 function(const DynamicDescription* self, ref BaseContainer  res, Int32 type, ref const String  name) FillDefaultContainer ;

	Bool					 function(Description *desc, ref const DescID  did, ref const AtomArray  op, RESOURCEDATATYPEPLUGIN *resdatatypeplugin, ref const BaseContainer  bc, DescID *singledescid)GetSubDescriptionWithData;
	Bool					 function(Description *desc, ref const DescID  searchid, ref const AtomArray  ops, DescID *completeid)CheckDescID;

	DescEntry*				 function(Description *desc, ref const AtomArray  op) DescEntryGetFirst;
	DescEntry*				 function(Description *desc, DescEntry *de) DescEntryGetNext;
	DescEntry*				 function(Description *desc, DescEntry *de) DescEntryGetDown;
	void					 function(Description *desc, DescEntry *de, const BaseContainer **bc, ref DescID  descid)DescEntryGetDescEntry;
	String					 function(AtomArray *arr) DescGenerateTitle;

	Bool					 function(DescID *id, HyperFile *hf) DescID_Read;
	Bool					 function(DescID *id, HyperFile *hf) DescID_Write;
	Bool					 function(DynamicDescription* self, ref const DescID  descid, ref const BaseContainer  datadescription, BaseList2D *bl) DDSet;

	UInt32					 function(const DynamicDescription* self) GetDirty ;

	const DescID			 function(DescID *d1, DescID *d2)DescID_AddTo;
	DescID					 function(DescID *d1, DescID *d2)DescID_Add;
};

// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF

//###############################################################################
//###############################################################################
//###############################################################################
alias LIBID		= LIBRARY_DESCRIPTIONLIB;
alias LIB		= DescriptionLib;


static __gshared LIB *library = nullptr;


static LIB *CheckLibObjectList(Int32 offset)
{
	return cast(LIB*)CheckLib(LIBID, offset, cast(C4DLibrary**)&library);
}

Bool Description_Register(Int32 id, ref const String  idstr, LocalResource *res)
{
	LIB *lib = CheckLibObjectList(LIBOFFSET!(LIB.Register)); if (!lib || !lib.Register) return false;
	return lib.Register(id, idstr, res);
}


