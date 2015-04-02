
module c4d_baselist;

import c4d;
import c4d_os;

//regex:
/// AtCall\((\w+)\)\s*\(
/// C4DOS.At.$1(&this, 

//regex:
/// BoCall\((\w+)\)\s*\(
/// C4DOS.Bo.$1(&this,  

//=============================================================================
struct C4DAtom
{
private:
	@disable this(); // C4DAtom();
	//~C4DAtom();

public:
	Int32 GetType() const { return C4DOS.At.GetType(&this ); }
	Int32 GetRealType() const { return C4DOS.At.GetRealType(&this ); }
	Int32 GetDiskType() const { return C4DOS.Bl.GetDiskType(&this); }
	Bool IsInstanceOf(Int32 id) const { return C4DOS.At.IsInstanceOf(&this, id); }
	Int32 GetClassification() const { return C4DOS.At.GetClassification(&this ); }

	Bool Message(Int32 type, void* data = nullptr) { return C4DOS.At.Message(&this, type, data); }
	Bool MultiMessage(MULTIMSG_ROUTE flags, Int32 type, void* data) { return C4DOS.At.MultiMessage(&this, flags, type, data); }

	C4DAtom* GetClone(COPYFLAGS flags, AliasTrans* trn) { return C4DOS.At.GetClone(&this, flags, trn); }
	Bool CopyTo(C4DAtom* dst, COPYFLAGS flags, AliasTrans* trn) { return C4DOS.At.CopyTo(&this, dst, flags, trn); }

	Bool Read(HyperFile* hf, Int32 id, Int32 level);
	Bool Write(HyperFile* hf);
	Bool ReadObject(HyperFile* hf, Bool readheader);
	Bool WriteObject(HyperFile* hf);

	Bool GetDescription(Description* description, DESCFLAGS_DESC flags);
	Bool GetParameter(ref const DescID  id, ref GeData  t_data, DESCFLAGS_GET flags);
	Bool SetParameter(ref const DescID  id, ref const GeData  t_data, DESCFLAGS_SET flags);
	DynamicDescription* GetDynamicDescription();
	Bool GetEnabling(ref const DescID  id, ref const GeData  t_data, DESCFLAGS_ENABLE flags, const BaseContainer* itemdesc);
	Bool TranslateDescID(ref const DescID  id, ref DescID  res_id, ref C4DAtom*  res_at);

	UInt32 GetDirty(DIRTYFLAGS flags) const { return C4DOS.Bo.GetDirty(&this, flags); }
	void SetDirty(DIRTYFLAGS flags) { C4DOS.Bo.SetDirty(&this, flags); }

	UInt32 GetHDirty(HDIRTYFLAGS mask) const { return C4DOS.Bo.GetHDirty(&this,mask); }
	void SetHDirty(HDIRTYFLAGS mask)		{ C4DOS.Bo.SetHDirty(&this,mask); }
};
//=============================================================================
struct C4DAtomGoal //: C4DAtom
{
	C4DAtom parent; //?
	alias parent this; //? 
private:
	@disable this(); //C4DAtomGoal();
	// ~C4DAtomGoal();
};

//=============================================================================
struct GeListNode //: C4DAtomGoal
{
	C4DAtomGoal parent; //?
	alias parent this; //? 
private:
	@disable this(); //GeListNode();
	// ~GeListNode();

public:
	GeListNode* GetNext() { return C4DOS.At.GetNext(&this ); }
	GeListNode* GetPred() { return C4DOS.At.GetPred(&this ); }
	GeListNode* GetDown() { return C4DOS.At.GetDown(&this ); }
	GeListNode* GetUp  () { return C4DOS.At.GetUp(&this ); }
	GeListNode* GetDownLast() { return C4DOS.At.GetDownLast(&this ); }

	void InsertBefore		(GeListNode* bl) { C4DOS.At.InsertBefore(&this, bl); }
	void InsertAfter    (GeListNode* bl) { C4DOS.At.InsertAfter(&this, bl); }
	void InsertUnder    (GeListNode* bl) { C4DOS.At.InsertUnder(&this, bl); }
	void InsertUnderLast(GeListNode* bl) { C4DOS.At.InsertUnderLast(&this, bl); }
	void Remove() { C4DOS.At.Remove(&this ); }

	GeListHead* GetListHead() { return C4DOS.At.GetListHead(&this ); }

	Int32	GetNodeID  (Int32 index = 0) const { return C4DOS.Bl.GetNodeID(cast(GeListNode*)&this, index); }
	NodeData* GetNodeData(Int32 index = 0) const { return C4DOS.Bl.GetNodeData(cast(GeListNode*)&this, index); }

	void SetCustomData(GeListNode* node);
	GeListNode*	GetCustomData();

	BaseDocument* GetDocument() { return C4DOS.At.GetDocument(&this, ); }
	Int32 GetBranchInfo(BranchInfo* info, Int32 max, GETBRANCHINFO flags) { return C4DOS.At.GetBranchInfo(&this, info, max, flags); }
	Bool IsDocumentRelated() { return C4DOS.At.IsDocumentRelated(&this, ); }

	// new bit function for 64 bits at the moment
	Bool GetNBit(NBIT bit) const;
	Bool ChangeNBit(NBIT bit, NBITCONTROL bitmode);
	Int32 GetInfo();
};

static assert(GeListNode.sizeof == 1);
static assert(BaseList2D.sizeof == 1); 

//=============================================================================
struct BaseList2D //: GeListNode
{
	GeListNode parent; //?
	alias parent this; //? 
private:
	@disable this(); //BaseList2D();
	//~BaseList2D();

public:
	BaseList2D* GetNext() { return cast(BaseList2D*)C4DOS.At.GetNext(cast(GeListNode*)&this ); }
	BaseList2D* GetPred() { return cast(BaseList2D*)C4DOS.At.GetPred(cast(GeListNode*)&this ); }

	void SetBit   (Int32 mask) { C4DOS.Bl.SetAllBits(&this, C4DOS.Bl.GetAllBits(&this) | mask); }
	Bool GetBit   (Int32 mask) const { return (C4DOS.Bl.GetAllBits(&this) & mask) == mask; }
	void DelBit   (Int32 mask) { C4DOS.Bl.SetAllBits(&this, C4DOS.Bl.GetAllBits(&this) & ~mask); }
	void ToggleBit(Int32 mask) {
		Int32 bitfield = C4DOS.Bl.GetAllBits(&this);
		if (bitfield & mask) bitfield = bitfield & ~mask;
		else				 bitfield = bitfield | mask;
		C4DOS.Bl.SetAllBits(&this, bitfield);
	}
	Int32 GetAllBits() const { return C4DOS.Bl.GetAllBits(&this);	}
	void SetAllBits(Int32 bits) { C4DOS.Bl.SetAllBits(&this, bits); }

	BaseContainer GetData() { BaseContainer bc; C4DOS.Bl.GetData(&this, &bc); return bc; }
	void SetData(ref const BaseContainer  bc, Bool add = true) { C4DOS.Bl.SetData(&this, &bc, add); }
	BaseContainer* GetDataInstance() const { return C4DOS.Bl.GetDataInstance(cast(BaseList2D*)(&this));	}
	BaseContainer* GetDataInstance() { return C4DOS.Bl.GetDataInstance(&this); }

	//? ref const String  GetName() const { return C4DOS.At.GetName(&this ); }
	void SetName(ref const String  name) { C4DOS.At.SetName(&this, name); }

	String GetBubbleHelp() { return C4DOS.Bl.GetBubbleHelp(&this); }

	Bool TransferGoal(BaseList2D* dst, Bool undolink) { return C4DOS.At.TransferGoal(&this, dst, undolink); }
	Bool TransferMarker(BaseList2D* dst) const { return C4DOS.At.TransferMarker(&this, dst); }

	//? void GetMarkerStampEx(UInt32* l1, UInt32* l2) { return C4DOS.Bl.GetMarker(&this, l1, l2); }
	//? ref const GeMarker  GetMarker() const { return C4DOS.At.GetMarker(&this, ); }
	//? void SetMarker(ref const GeMarker  m) { C4DOS.At.SetMarker(&this, m); }

	Bool AddUniqueID(Int32 appid, const Char* mem, Int bytes) { return C4DOS.At.AddUniqueID(&this, appid, mem, bytes); }
	Bool FindUniqueID(Int32 appid, ref const Char*  mem, ref Int  bytes) const { return C4DOS.At.FindUniqueID(&this, appid, mem, bytes); }
	Int32 GetUniqueIDCount() const { return C4DOS.At.GetUniqueIDCount(&this ); }
	Bool GetUniqueIDIndex(Int32 idx, ref Int32  id, ref const Char*  mem, ref Int  bytes) const { return C4DOS.At.GetUniqueIDIndex(&this, idx, id, mem, bytes); }

	//! Bool SetAnimatedParameter(CTrack* track, ref const DescID  id, ref const GeData  t_data1, ref const GeData  t_data2, Float mix, DESCFLAGS_SET flags);
	//! Bool GetAnimatedParameter(ref const DescID  id, ref GeData  t_data1, ref GeData  t_data2, ref Float  mix, DESCFLAGS_GET flags);

	Bool Scale(Float scale) { return C4DOS.At.Scale(&this, scale); }

	BaseShader* GetFirstShader() const { return C4DOS.At.GetFirstShader(&this, ); }
	void InsertShader(BaseShader* shader, BaseShader* pred = nullptr) { C4DOS.At.InsertShader(&this, shader, pred); }

	/+
	Bool Edit();

	void GetIcon(IconData* dat);

	void ClearKeyframeSelection();
	Bool FindKeyframeSelection(ref const DescID  id);
	Bool SetKeyframeSelection(ref const DescID  id, Bool selection);
	Bool KeyframeSelectionContent();

	// layer
	LayerObject* GetLayerObject(BaseDocument* doc);
	Bool SetLayerObject(LayerObject* layer);
	const LayerData* GetLayerData  (BaseDocument* doc, Bool rawdata = false);
	Bool SetLayerData  (BaseDocument* doc, ref const LayerData  data);

	// new animation system
	GeListHead* GetCTrackRoot();
	CTrack*     GetFirstCTrack();
	CTrack*     FindCTrack(ref const DescID  id);

	// new nla system
	GeListHead* GetNLARoot();

	// returns remapped baselist pointer if active animation layer is existent, you can optionally access this layer by passing layer into the routine
	// if there is no active layers or no layer at all 'this' will be returned
	BaseList2D* AnimationLayerRemap(BaseObject** layer = nullptr);

	ref const String  GetTypeName();	// typisierter Kategorie-Name, z.B. Phong, Spline, Bone
	BaseList2D* GetMain() const;

	void InsertTrackSorted(CTrack* track);

	Bool AddEventNotification(BaseList2D* bl, NOTIFY_EVENT eventid, NOTIFY_EVENT_FLAG flags, const BaseContainer* data);
	Bool RemoveEventNotification(BaseDocument* doc, BaseList2D* bl, NOTIFY_EVENT eventid);
	Bool FindEventNotification(BaseDocument* doc, BaseList2D* bl, NOTIFY_EVENT eventid);

	Bool SetDescIDState(ref const DescID  id, DESCIDSTATE descidstate);
	DESCIDSTATE GetDescIDState(ref const DescID  id, Bool tolerant) const;

	static BaseList2D* Alloc(Int32 type);
	static void Free(ref BaseList2D*  bl);
	+/
};

/+

/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////

#ifndef __C4DBASELIST_H
#define __C4DBASELIST_H

#ifdef __API_INTERN__

	#include "intbaselist.h"
	#include "objectarray.h"
	#define AtCall(fnc) (this.*C4DOS.At.fnc)

#else

	#include "ge_math.h"
	#include "operatingsystem.h"
	#include "c4d_string.h"
	#include "c4d_basecontainer.h"
	#include "c4d_gedata.h"

	// macros for instanceof
	#define INSTANCEOFROOT(X)
	#define INSTANCEOF(X,Y)                  \
		public:                                \
			typedef Y SUPER;                     \
		private:
	// macros for instanceof

	#define AtCall(fnc) (this.*C4DOS.At.fnc)
	#define BoCall(fnc) (this.*C4DOS.Bo.fnc)
#endif

class DescID;
class InclusionTable;
class NodeData;
class GeListNode;
class GeListHead;
class BaseBitmap;
class SplineData;
class GeModalDialog;

#define MSG_REDIRECT_FLAG_PROCESSED (1 << 0)

struct RedirectMsgData	// MSG_REDIRECT
{
	Int32				type;
	void*				data;
	BaseList2D* bl;
	Int32				flags;
};

enum TOOLTRANSFORM_FLAG
{
	TOOLTRANSFORM_FLAG_NO_TRANSFORM=(1 << 0),
	TOOLTRANSFORM_FLAG_NO_RECURSE	 =(1 << 1),
	TOOLTRANSFORM_FLAG_NO_PARAMS	 =(1 << 2),
	//////////////////////////////////////////////////////////////////////////
	TOOLTRANSFORM_FLAG_0					 =0
} ENUM_END_FLAGS(TOOLTRANSFORM_FLAG);

struct ToolTransformMsgData	// MSG_TOOL_TRANSFORM
{
	Float							 scl;
	Matrix						 tm, mm, up;
	Bool							 children;
	BaseObject*				 undo;
	TOOLTRANSFORM_FLAG flags;
};

struct TagModifyMsgData	// MSG_TAG_MODIFY
{
	Bool calculateFirst;	//When try the result of GetModifiedObjects will be calculated first
	TagModifyMsgData() : calculateFirst(false) { }
};

struct ObjectTransformMsgData
{
	BaseObject* undo;
	Matrix			tm;
	Bool				sdown, useselection;
	Int32				mode;
	BaseDraw*		bd;
};

struct ToolAskMsgData
{
	// input values
	Int32								 version;
	EditorWindow*				 bw;
	BaseDocument*				 doc;
	Int32								 x, y, button;
	const BaseContainer* msg;
	BaseDraw*						 bd;

	// result values
	Bool	popup_exit;				// set to true if you already did everything and canceling mouseinput in the core
	Bool	popup_allowed;		// set to false if you want to prevent core from opening a popup
	Int32 popup_menuid;			// set to any menuid if you want to use the std popup. e.g. M_MODELING_POLYGON
	Bool	use_middlemouse;	// set to true if you want to use the middle mouse button to do something in the mouseinput
	Bool	use_rightmouse;		// set to true if you want to use the right mouse button to do something in the mouseinput
	Bool	resize_allowed;		// set to true to accept sizing messages for brushes
	Bool	use_singleclick;	// set to true to allow single clicks to select components/objects

	ToolAskMsgData() : version(1), bw(nullptr), doc(nullptr), x(0), y(0), button(0), msg(nullptr), bd(nullptr),
		popup_exit(false), popup_allowed(true), popup_menuid(0), use_middlemouse(false), use_rightmouse(false), resize_allowed(false), use_singleclick(false) { }
};

struct ToolResizeData
{
	enum RESIZE_PASS
	{
		RESIZE_PASS_INIT						=	0,	// Called before resizing starts
		RESIZE_PASS_GENERATEFALLOFF	= 1,	// Called when a custom falloff needs to be generated
		RESIZE_PASS_RESIZE					=	2,	// Called during the resizing process
		RESIZE_PASS_END							=	3,	// Called to end the resizing process
		RESIZE_PASS_RESET						=	4		// Called to reset resizing (user cancelled action)
	} pass;
	Int32					 delta;								// Mouse movement delta
	Int32					 total_delta;					// Mouse movement delta
	Bool					 horizontal;					// true if a horizontal movement is occurring (and cross_type has been set to true in the RESIZE_PASS_INIT pass by the user)
	BaseContainer* data;								// A pointer to the tool's BaseContainer

	// result values
	Bool cross_type;	// Set to false to disable cross type resizing, where the primary direction the mouse is moved in dictates movement afterwards

	//Radial falloff display preview settings
	struct ToolResizeFalloffData
	{
		ToolResizeFalloffData() : show(false), opacity(1.0), size(0.0), hardness(0.0), color(1.0), is_3D(false), dirty(false), falloff(nullptr), custom_shape(nullptr) { }

		Bool				show;					// Show the falloff for the brush increment to force dirtyness for the falloff_spline or custom_shape
		Float				opacity;			// Opacity of the brush display preview
		Float				size;					// Size of the brush display preview
		Float				hardness;			// Hardness of the brush display preview
		Vector			color;				// The color for the brush display preview
		Matrix			position;			// The center of the falloff, just use the Matrix::off for 2D brushes
		Bool				is_3D;				// Optionally display the falloff in 3D
		Bool				dirty;				// Set to true to redraw the custom shape
		SplineData* falloff;			// Custom falloff spline, allocate and set in RESIZE_PASS_GENERATEFALLOFF to use, caller owns and must release in RESIZE_PASS_END
		BaseBitmap* custom_shape;	// Allocate in RESIZE_PASS_INIT to use as a custom shape instead of the normal one, fill in RESIZE_PASS_GENERATEFALLOFF caller owns and must release in RESIZE_PASS_END
	} falloff;

	//String text to display next to the cursor
	String cursor_text;	// The text to show next to the cursor

	ToolResizeData() : pass(RESIZE_PASS_RESIZE), delta(0), total_delta(0), horizontal(NOTOK), data(nullptr), cross_type(true) { }
};

struct DescriptionImExportInit
{
	BaseDocument* doc;
	GeModalDialog*	dlg;
};

#define MSG_POINTS_CHANGED												1
#define MSG_POLYGONS_CHANGED											2
#define MSG_UPDATE																5
#define MSG_SMALLUPDATE														6
#define MSG_CHANGE																7
#define MSG_BASECONTAINER													9
#define MSG_SEGMENTS_CHANGED											10
#define MSG_FILTER																14
#define MSG_TRANSFERGOALS													15
#define MSG_DESCRIPTION_INITUNDO									16
#define MSG_DESCRIPTION_CHECKUPDATE								17
#define MSG_DESCRIPTION_CHECKUPDATE_DOCUMENT			(1 << 1)
#define MSG_DESCRIPTION_CHECKUPDATE_AUTOKEY				(1 << 2)
#define MSG_DESCRIPTION_CHECKUPDATE_SYNC					(1 << 4)
#define MSG_DESCRIPTION_CHECKUPDATE_ANIMATE				(1 << 5)
#define MSG_DESCRIPTION_CHECKUPDATE_NOSCENEUPDATE	(1 << 23)
#define MSG_DESCRIPTION_COMMAND										18	// data contains the id
#define MSG_DESCRIPTION_POPUP											300001046
#define MSG_DESCRIPTION_POSTSETPARAMETER					19
#define MSG_DESCRIPTION_VALIDATE									20
#define MSG_EDIT																	21
#define MSG_MENUPREPARE														22
#define MSG_RETRIEVEPRIVATEDATA										23
#define MSG_DESCRIPTION_REMOVE_ENTRY							24	// data contains DescriptionCommand
#define MSG_DESCRIPTION_EDIT_ENTRY								25	// data contains DescriptionCommand
#define MSG_DESCRIPTION_CHECKDRAGANDDROP					26
#define MSG_DESCRIPTION_GETBITMAP									27
#define MSG_DESCRIPTION_GETOBJECTS								30
#define MSG_DESCRIPTION_USERINTERACTION_END				31
#define MSG_DESCRIPTION_GETINLINEOBJECT						200000169	// struct DescriptionInlineObjectMsg
#define MSG_DESCRIPTION_IMPEXPORT_INIT						200000288
#define	MSG_MOVE_FINISHED													32
#define MSG_MOVE_START														1021543
#define MSG_EDITABLE_END													33
#define MSG_GETCUSTOMICON													1001090
#define MSG_MATERIALDRAGANDDROP										1001069
#define MSG_DRAGANDDROP														1018756
#define MSG_INITIALCHANNEL												1001073
#define MSG_PYTHON_RESET													1024114
#define MSG_DOCUMENTINFO													1001078
#define MSG_DOCUMENTINFO_TYPE_SETACTIVE						1000
#define MSG_DOCUMENTINFO_TYPE_LOAD								1001
#define MSG_DOCUMENTINFO_TYPE_MERGE								1002
#define MSG_DOCUMENTINFO_TYPE_BEFOREMERGE					1003
#define MSG_DOCUMENTINFO_TYPE_SAVE_BEFORE					1004
#define MSG_DOCUMENTINFO_TYPE_SAVE_AFTER					1005
#define MSG_DOCUMENTINFO_TYPE_SAVEPROJECT_BEFORE	1006
#define MSG_DOCUMENTINFO_TYPE_SAVEPROJECT_AFTER		1007
#define MSG_DOCUMENTINFO_TYPE_REMOVE							1008
#define	MSG_DOCUMENTINFO_TYPE_TOOL_CHANGED				1009
#define	MSG_DOCUMENTINFO_TYPE_OBJECT_INSERT				1010
#define	MSG_DOCUMENTINFO_TYPE_TAG_INSERT					1011
#define	MSG_DOCUMENTINFO_TYPE_MATERIAL_INSERT			1012
#define	MSG_DOCUMENTINFO_TYPE_UNDO								1013
#define	MSG_DOCUMENTINFO_TYPE_REDO								1014
#define	MSG_DOCUMENTINFO_TYPE_PASTE								1015
#define	MSG_DOCUMENTINFO_TYPE_COPY								1016
#define MSG_DOCUMENTINFO_TYPE_LOAD_XREFS					1017	// private
#define MSG_DOCUMENTINFO_TYPE_MERGE_XREFS					1018	// private
#define MSG_DOCUMENTINFO_TYPE_XREFS_IMPORTED			1019	// private
#define	MSG_DOCUMENTINFO_TYPE_MAKEPROJECT					1020
#define	MSG_DOCUMENTINFO_TYPE_RENDER_CLONE				1021
#define MSG_GETSELECTION													1022176
#define MSG_REDIRECT															1023019
#define MSG_TOOL_TRANSFORM												1025528
#define MSG_GETACTIVEREDIRECT											1025664
#define MSG_TOOL_ASK															200000285
#define MSG_TAG_MODIFY														1027944
#define MSG_TOOL_RESIZE														440000137
#define MSG_CURRENTSTATE_END											1028521
#define MSG_ALLOWXPRESSODROP											1030412

#define MSG_MULTI_RENDERNOTIFICATION	 1001071
#define MSG_MULTI_MARKMATERIALS				 (4 | (1 << 30))
#define MSG_MULTI_DOCUMENTCLONED			 11
#define MSG_MULTI_DOCUMENTIMPORTED		 13
#define MSG_MULTI_SETNEWMARKERS				 200000161
#define MSG_MULTI_CLEARSUGGESTEDFOLDER 200000040

#define MSG_TRANSLATE_POINTS				 1015632
#define MSG_TRANSLATE_POLYGONS			 1015633
#define MSG_TRANSLATE_NGONS					 1015634
#define MSG_TRANSLATE_SEGMENTS			 1015831
#define MSG_PRETRANSLATE_POINTS			 1015822
#define MSG_PRETRANSLATE_POLYGONS		 1015823
#define MSG_PRETRANSLATE_NGONS			 1015824
#define MSG_PRETRANSLATE_SEGMENTS		 1015832
#define MSG_UPDATE_NGONS						 475000000
#define	MSG_DOCUMENT_MODE_CHANGED		 200000091	// tool message when doc::d_modus changed
#define MSG_TOOL_RESTART						 200000096
#define MSG_DEFORMMODECHANGED				 200000125
#define MSG_ANIMATE									 300001037
#define MSG_CALCMEMUSAGE						 200000160
#define MSG_SCALEDOCUMENT						 300001069
#define MSG_GET_INHERITANCECONTAINER 300001052
#define MSG_SOFTTAG_UPDATE					 1016685
#define MSG_TRANSFORM_OBJECT				 440000109	// Private
#define MSG_STRINGUNDO							 300001071	// Private
#define MSG_GETREALCAMERADATA				 1028476
#define MSG_ADAPTVIEW_START					 1028478
#define MSG_ADAPTVIEW_END						 1028479

struct StringUndo
{
	String str;
	Bool	 redo;
};

struct VariableChanged
{
	VariableChanged();

	Int32 old_cnt, new_cnt, *map;
	Int32 vc_flags;
#define VC_SAFETY				 (1 << 0)
#define VC_DONTCOPYDATA	 (1 << 1)
#define VC_DONTCLEARDATA (1 << 2)
};

struct DocumentImported	// MSG_MULTI_DOCUMENTIMPORTED
{
	DocumentImported() { doc = nullptr; c4dversion = 0; fileformat = 0; gui_allowed = false; }

	BaseDocument* doc;
	Int32					c4dversion;
	Int32					fileformat;
	Bool					gui_allowed;
};

struct MarkMaterials	// MSG_MULTI_MARKMATERIALS
{
	MarkMaterials() { omat = nmat = nullptr; }

	BaseMaterial* omat;
	BaseMaterial* nmat;
};

struct DescriptionInitUndo	// MSG_DESCRIPTION_INITUNDO
{
	DescriptionInitUndo() { doc = nullptr; descid = nullptr; }

	BaseDocument* doc;
	const DescID* descid;
};

struct DescriptionCheckUpdate	// MSG_DESCRIPTION_CHECKUPDATE
{
	DescriptionCheckUpdate() { doc = nullptr; drawflags = 0; descid = nullptr; }

	BaseDocument* doc;
	Int32					drawflags;
	const DescID* descid;
};

struct DescriptionValidate	// MSG_DESCRIPTION_VALIDATE
{
	DescriptionValidate() { flags = 0; }

	Int32 flags;
};

struct DescriptionPostSetValue
{
	DescriptionPostSetValue() : descid(nullptr) { }

	const DescID* descid;
};

struct RetrievePrivateData	// MSG_RETRIEVEPRIVATEDATA
{
	RetrievePrivateData () { flags = 0; data = nullptr; }

	Int32	flags;
	void* data;
};

struct MaterialDragAndDrop	// MSG_MATERIALDRAGANDDROP
{
	MaterialDragAndDrop() { doc = nullptr; op = nullptr; result = nullptr; }

	BaseDocument* doc;
	BaseObject*		op;
	BaseTag*			result;
};

struct GetRealCameraData
{
	GetRealCameraData() : res(nullptr) { }
	BaseObject* res;
};

#define DRAGANDDROP_FLAG_RECEIVE	1
#define DRAGANDDROP_FLAG_DROP			2
#define DRAGANDDROP_FLAG_ACCEPT		4
#define DRAGANDDROP_FLAG_MSGVALID	8

#define DRAGANDDROP_FLAG_FORBID	(1 << 4)
#define DRAGANDDROP_FLAG_SOURCE	(1 << 5)
#define DRAGANDDROP_FLAG_BEFORE	(1 << 6)
#define DRAGANDDROP_FLAG_AFTER	(1 << 7)
#define DRAGANDDROP_FLAG_LEFT		(1 << 8)
#define DRAGANDDROP_FLAG_RIGHT	(1 << 9)

#define OBJSELDATA_FLAG_QUERYSELECTION 1	// check if MSG_GETSELECTION is available
#define OBJSELDATA_FLAG_HASSELECTION	 2	// MSG_GETSELECTION is available (return)

struct DragAndDrop												// MSG_DRAGANDDROP
{
	DragAndDrop() { doc = nullptr; sender = nullptr; flags = 0; type = 0; data = nullptr; x = y = 0; msg = nullptr; result = 0; }

	BaseDocument*				 doc;
	C4DAtom*						 sender;
	UInt32							 flags;
	Int32								 type;
	void*								 data;
	Int32								 x, y;
	const BaseContainer* msg;
	Int32								 result;
};

struct ObjectSelectionData	// MSG_GETSELECTION
{
	ObjectSelectionData() { doc = nullptr; table = nullptr; flags = 0; }

	BaseDocument*		doc;
	InclusionTable* table;
	UInt32					flags;
};

struct RenderNotificationData
{
	RenderNotificationData() { doc = nullptr; start = animated = external = false; render = nullptr; }

	BaseDocument* doc;
	Bool					start, animated, external;
	Render*				render;
};

struct DocumentInfoClipData	// MSG_DOCUMENTINFO_TYPE_COPY, MSG_DOCUMENTINFO_TYPE_PASTE
{
	DocumentInfoClipData() { arr = nullptr; trans = nullptr; bcdata = nullptr; }

	const AtomArray* arr;
	AliasTrans*			 trans;
	BaseContainer*	 bcdata;
};

struct DocumentInfoMakeProj	// MSG_DOCUMENTINFO_TYPE_MAKEPROJECT
{
	DocumentInfoMakeProj()
	{
		allowCopy = false;
		allowGUI = false;
	}

	Filename sfile, dfile;
	Bool allowCopy;
	Bool allowGUI;
};

struct DocumentInfoData
{
	DocumentInfoData() { type = 0; fileformat = 0; doc = nullptr; bl = nullptr; gui_allowed = false; data = nullptr; }

	Int32					type;
	Int32					fileformat;
	BaseDocument* doc;
	Filename			filename;
	BaseList2D*		bl;
	Bool					gui_allowed;
	void*					data;	// depends on MSG_DOCUMENTINFO_TYPE_
};

class AssetEntry
{
public:
	Filename _filename;
	String	 _assetname;
	Int32		 _channelId;
	Bool		 _netRequestOnDemand;

	AssetEntry(const Filename& filename, const String& assetname, Int32 channelId, Bool netRequestOnDemand) : _filename(filename), _assetname(assetname), _channelId(channelId), _netRequestOnDemand(netRequestOnDemand) { }
};

struct AssetData
{
	AssetData(BaseDocument* t_doc, RootTextureString* t_rs, ASSETDATA_FLAG t_flags) : doc(t_doc), rs(t_rs), flags(t_flags) { }

	BaseDocument*			 doc;
	RootTextureString* rs;
	ASSETDATA_FLAG		 flags;

	Bool Add(const Filename& fn, BaseList2D* bl, Bool netRequestOnDemand = false);
};

// MSG_DOCUMENTINFO_TYPE_BEFOREMERGE, *data points to MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT
enum MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT
{
	MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT_CANCEL,
	MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT_MERGE,
	MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT_NEWSCENE,
}
ENUM_END_LIST(MSG_DOCUMENTINFO_TYPE_BEFOREMERGE_RESULT);

struct GetCustomIconData	// data for MSG_GETCUSTOMICON
{
	GetCustomIconData() { dat = nullptr; filled = false; }

	IconData* dat;
	Bool			filled;	// must be set to true if command modifies the icondata
};

struct DescriptionInlineObjectMsg
{
	DescriptionInlineObjectMsg() : id(nullptr), objects(nullptr) { }

	const DescID* id;
	AtomArray*		objects;
};

struct MessageScaleDocument
{
	MessageScaleDocument() { scale = 1.0; }

	Float	scale;
};

struct MessageFilter
{
	MessageFilter() { type = 0; route = MULTIMSG_ROUTE_NONE; data = nullptr; }

	Int32					 type;
	MULTIMSG_ROUTE route;
	void*					 data;
};

struct BranchInfo
{
	GeListHead*			head;
	const String*		name;
	Int32						id;
	BRANCHINFOFLAGS	flags;
};

#define	MSG_NOTIFY_EVENT 1024639

class NotifyEventMsg
{
public:
	NotifyEventMsg() { msg_id = 0; msg_data = nullptr; }

	Int32 msg_id;
	void* msg_data;
};

class NotifyEventCopy
{
public:
	NotifyEventCopy() { cpy_dst = nullptr; cpy_flags = COPYFLAGS_0; cpy_trans = nullptr; }

	BaseList2D* cpy_dst;
	COPYFLAGS		cpy_flags;
	AliasTrans* cpy_trans;
};

class NotifyEventData
{
public:
	NotifyEventData() { bl = nullptr; eventid = NOTIFY_EVENT_NONE; user_data = nullptr; event_data = nullptr; doc = nullptr; }

	BaseDocument*				 doc;
	BaseList2D*					 bl;
	NOTIFY_EVENT				 eventid;
	const BaseContainer* user_data;
	void*								 event_data;
};

#ifndef __API_INTERN__

class GeMarker
{
private:
	GeMarker();
	~GeMarker();

public:
	Bool Content() const { return AtCall(Content) (); }
	Bool IsEqual(const GeMarker& m) const	{ return AtCall(IsEqual) (m); }
	Int32 Compare(const GeMarker& m) const { return AtCall(Compare) (m); }
	void Set(const GeMarker& m)							{ AtCall(GeMarkerSet) (m); }
	Bool Read(HyperFile* hf)								{ return AtCall(GeMarkerRead) (hf); }
	Bool Write(HyperFile* hf) const	{ return AtCall(GeMarkerWrite) (hf); }
	void GetMemory(void*& data, Int32& size) const { AtCall(GeMarkerGetMemory) (data, size); }

	static GeMarker* Alloc()         { return (*C4DOS.At.GeMarkerAlloc)();	}
	static void Free(GeMarker*& obj) { (*C4DOS.At.GeMarkerFree)(obj); }
};

class C4DAtom
{
private:
	C4DAtom();
	~C4DAtom();

public:
	Int32 GetType() const { return AtCall(GetType) (); }
	Int32 GetRealType() const { return AtCall(GetRealType) (); }
	Int32 GetDiskType() const { return C4DOS.Bl.GetDiskType(this); }
	Bool IsInstanceOf(Int32 id) const { return AtCall(IsInstanceOf) (id); }
	Int32 GetClassification() const { return AtCall(GetClassification) (); }

	Bool Message(Int32 type, void* data = nullptr) { return AtCall(Message) (type, data); }
	Bool MultiMessage(MULTIMSG_ROUTE flags, Int32 type, void* data) { return AtCall(MultiMessage) (flags, type, data); }

	C4DAtom* GetClone(COPYFLAGS flags, AliasTrans* trn) { return AtCall(GetClone) (flags, trn); }
	Bool CopyTo(C4DAtom* dst, COPYFLAGS flags, AliasTrans* trn) { return AtCall(CopyTo) (dst, flags, trn); }

	Bool Read(HyperFile* hf, Int32 id, Int32 level);
	Bool Write(HyperFile* hf);
	Bool ReadObject(HyperFile* hf, Bool readheader);
	Bool WriteObject(HyperFile* hf);

	Bool GetDescription(Description* description, DESCFLAGS_DESC flags);
	Bool GetParameter(const DescID& id, GeData& t_data, DESCFLAGS_GET flags);
	Bool SetParameter(const DescID& id, const GeData& t_data, DESCFLAGS_SET flags);
	DynamicDescription* GetDynamicDescription();
	Bool GetEnabling(const DescID& id, const GeData& t_data, DESCFLAGS_ENABLE flags, const BaseContainer* itemdesc);
	Bool TranslateDescID(const DescID& id, DescID& res_id, C4DAtom*& res_at);

	UInt32 GetDirty(DIRTYFLAGS flags) const { return C4DOS.Bo.GetDirty(this, flags); }
	void SetDirty(DIRTYFLAGS flags) { C4DOS.Bo.SetDirty(this, flags); }

	UInt32 GetHDirty(HDIRTYFLAGS mask) const { return BoCall(GetHDirty) (mask); }
	void SetHDirty(HDIRTYFLAGS mask)		{ BoCall(SetHDirty) (mask); }
};

class C4DAtomGoal : public C4DAtom
{
private:
	C4DAtomGoal();
	~C4DAtomGoal();
};

class AtomArray
{
private:
	AtomArray();
	~AtomArray();

public:
	static AtomArray* Alloc()											{	return (*C4DOS.At.AtomArrayAlloc)();	}
	static void Free(AtomArray*& obj)							{ (*C4DOS.At.AtomArrayFree)(obj); }

	Int32 GetCount() const { return AtCall(GetCount) (); }
	Int32 GetCount(Int32 type, Int32 instance) const { return AtCall(AAGetCountTI) (type, instance); }
	C4DAtom* GetIndex(Int32 idx) const { return AtCall(GetIndex) (idx); }
	Bool Append(C4DAtom* obj)											{ return AtCall(Append) (obj); }
	void Flush()																	{ AtCall(Flush) (); }
	Bool Remove(C4DAtom* obj)											{ return AtCall(AARemove) (obj); }

	Bool CopyTo(AtomArray* dest) const { return AtCall(AACopyTo) (dest); }
	Bool CopyToFilter(AtomArray* dest, Int32 type, Int32 instance, Bool generators = true) const { return AtCall(AACopyToFilter) (dest, type, instance, generators); }

	Int32 GetUserID() const	{ return AtCall(AAGetUserID) (); }
	void SetUserID(Int32 t_userid)									{ AtCall(AASetUserID) (t_userid); }

	void* GetUserData() const	{ return AtCall(AAGetUserData) (); }
	void SetUserData(void* t_userdata)						{ AtCall(AASetUserData) (t_userdata); }

	C4DAtom* GetPreferred() const	{ return AtCall(AAGetPreferred) (); }
	void SetPreferred(C4DAtom* t_preferred)				{ AtCall(AASetPreferred) (t_preferred); }
	void FilterObject(Int32 type, Int32 instance, Bool generators = false)   { AtCall(AAFilterObject) (type, instance, generators); }
	void FilterObjectChildren()										{ AtCall(AAFilterObjectChildren) (); }
	Bool Append(AtomArray* src)										{ return AtCall(AAAppendArr) (src); }
	Int32 Find(C4DAtom* obj)												{ return AtCall(AAFind) (obj); }
	Bool Compare(AtomArray* cmp)									{ return AtCall(AACompareArr) (cmp); }
};

class GeListNode : public C4DAtomGoal
{
private:
	GeListNode();
	~GeListNode();

public:
	GeListNode* GetNext() { return AtCall(GetNext) (); }
	GeListNode* GetPred() { return AtCall(GetPred) (); }
	GeListNode* GetDown() { return AtCall(GetDown) (); }
	GeListNode* GetUp  () { return AtCall(GetUp) (); }
	GeListNode* GetDownLast() { return AtCall(GetDownLast) (); }

	void InsertBefore		(GeListNode* bl) { AtCall(InsertBefore) (bl); }
	void InsertAfter    (GeListNode* bl) { AtCall(InsertAfter) (bl); }
	void InsertUnder    (GeListNode* bl) { AtCall(InsertUnder) (bl); }
	void InsertUnderLast(GeListNode* bl) { AtCall(InsertUnderLast) (bl); }
	void Remove() { AtCall(Remove) (); }

	GeListHead* GetListHead() { return AtCall(GetListHead) (); }

	Int32	GetNodeID  (Int32 index = 0) const { return C4DOS.Bl.GetNodeID((GeListNode*)this, index); }
	NodeData* GetNodeData(Int32 index = 0) const { return C4DOS.Bl.GetNodeData((GeListNode*)this, index); }

	void SetCustomData(GeListNode* node);
	GeListNode*	GetCustomData();

	BaseDocument* GetDocument() { return AtCall(GetDocument) (); }
	Int32 GetBranchInfo(BranchInfo* info, Int32 max, GETBRANCHINFO flags) { return AtCall(GetBranchInfo) (info, max, flags); }
	Bool IsDocumentRelated() { return AtCall(IsDocumentRelated) (); }

	// new bit function for 64 bits at the moment
	Bool GetNBit(NBIT bit) const;
	Bool ChangeNBit(NBIT bit, NBITCONTROL bitmode);
	Int32 GetInfo();
};

class GeListHead : public GeListNode
{
private:
	GeListHead();
	~GeListHead();

	void InsertBefore		(GeListNode* bl) { AtCall(InsertBefore) (bl); }
	void InsertAfter    (GeListNode* bl) { AtCall(InsertAfter) (bl); }
	void InsertUnder    (GeListNode* bl) { AtCall(InsertUnder) (bl); }
	void InsertUnderLast(GeListNode* bl) { AtCall(InsertUnderLast) (bl); }
	void Remove() { AtCall(Remove) (); }

public:
	void SetParent(GeListNode* parent) { AtCall(SetParent) (parent); }
	GeListNode*	GetParent() { return AtCall(GetParent) (); }
	GeListNode*	GetFirst() { return AtCall(GetFirst) (); }
	GeListNode*	GetLast()  { return AtCall(GetLast) (); }
	void FlushAll() { AtCall(FlushAll) (); }
	void InsertFirst(GeListNode* bn) { AtCall(InsertFirst) (bn); }
	void InsertLast(GeListNode* bn) { AtCall(InsertLast) (bn); }
	void Insert(GeListNode* bn, GeListNode* parent, GeListNode* prev);

	static GeListHead* Alloc();
	static void Free(GeListHead*& v);
};

class BaseList2D : public GeListNode
{
private:
	BaseList2D();
	~BaseList2D();

public:
	BaseList2D* GetNext() { return (BaseList2D*)AtCall(GetNext) (); }
	BaseList2D* GetPred() { return (BaseList2D*)AtCall(GetPred) (); }

	void SetBit   (Int32 mask) { C4DOS.Bl.SetAllBits(this, C4DOS.Bl.GetAllBits(this) | mask); }
	Bool GetBit   (Int32 mask) const { return (C4DOS.Bl.GetAllBits(this) & mask) == mask; }
	void DelBit   (Int32 mask) { C4DOS.Bl.SetAllBits(this, C4DOS.Bl.GetAllBits(this) & ~mask); }
	void ToggleBit(Int32 mask);
	Int32 GetAllBits() const { return C4DOS.Bl.GetAllBits(this);	}
	void SetAllBits(Int32 bits) { C4DOS.Bl.SetAllBits(this, bits); }

	BaseContainer GetData() { BaseContainer bc; C4DOS.Bl.GetData(this, &bc); return bc; }
	void SetData(const BaseContainer& bc, Bool add = true) { C4DOS.Bl.SetData(this, &bc, add); }
	const BaseContainer* GetDataInstance() const { return C4DOS.Bl.GetDataInstance(const_cast<BaseList2D*>(this)); }
	BaseContainer* GetDataInstance() { return C4DOS.Bl.GetDataInstance(this); }

	const String& GetName() const { return AtCall(GetName) (); }
	void SetName(const String& name) { AtCall(SetName) (name); }

	String GetBubbleHelp() { return C4DOS.Bl.GetBubbleHelp(this); }

	Bool TransferGoal(BaseList2D* dst, Bool undolink) { return AtCall(TransferGoal) (dst, undolink); }
	Bool TransferMarker(BaseList2D* dst) const { return AtCall(TransferMarker) (dst); }

	void GetMarkerStampEx(UInt32* l1, UInt32* l2) { return C4DOS.Bl.GetMarker(this, l1, l2); }
	const GeMarker& GetMarker() const { return AtCall(GetMarker) (); }
	void SetMarker(const GeMarker& m) { AtCall(SetMarker) (m); }

	Bool AddUniqueID(Int32 appid, const Char* const mem, Int bytes) { return AtCall(AddUniqueID) (appid, mem, bytes); }
	Bool FindUniqueID(Int32 appid, const Char*& mem, Int& bytes) const { return AtCall(FindUniqueID) (appid, mem, bytes); }
	Int32 GetUniqueIDCount() const { return AtCall(GetUniqueIDCount) (); }
	Bool GetUniqueIDIndex(Int32 idx, Int32& id, const Char*& mem, Int& bytes) const { return AtCall(GetUniqueIDIndex) (idx, id, mem, bytes); }

	Bool SetAnimatedParameter(CTrack* track, const DescID& id, const GeData& t_data1, const GeData& t_data2, Float mix, DESCFLAGS_SET flags);
	Bool GetAnimatedParameter(const DescID& id, GeData& t_data1, GeData& t_data2, Float& mix, DESCFLAGS_GET flags);

	Bool Scale(Float scale) { return AtCall(Scale) (scale); }

	BaseShader* GetFirstShader() const { return AtCall(GetFirstShader) (); }
	void InsertShader(BaseShader* shader, BaseShader* pred = nullptr) { AtCall(InsertShader) (shader, pred); }

	Bool Edit();

	void GetIcon(IconData* dat);

	void ClearKeyframeSelection();
	Bool FindKeyframeSelection(const DescID& id);
	Bool SetKeyframeSelection(const DescID& id, Bool selection);
	Bool KeyframeSelectionContent();

	// layer
	LayerObject* GetLayerObject(BaseDocument* doc);
	Bool SetLayerObject(LayerObject* layer);
	const LayerData* GetLayerData  (BaseDocument* doc, Bool rawdata = false);
	Bool SetLayerData  (BaseDocument* doc, const LayerData& data);

	// new animation system
	GeListHead* GetCTrackRoot();
	CTrack*     GetFirstCTrack();
	CTrack*     FindCTrack(const DescID& id);

	// new nla system
	GeListHead* GetNLARoot();

	// returns remapped baselist pointer if active animation layer is existent, you can optionally access this layer by passing layer into the routine
	// if there is no active layers or no layer at all 'this' will be returned
	BaseList2D* AnimationLayerRemap(BaseObject** layer = nullptr);

	const String& GetTypeName();	// typisierter Kategorie-Name, z.B. Phong, Spline, Bone
	BaseList2D* GetMain() const;

	void InsertTrackSorted(CTrack* track);

	Bool AddEventNotification(BaseList2D* bl, NOTIFY_EVENT eventid, NOTIFY_EVENT_FLAG flags, const BaseContainer* data);
	Bool RemoveEventNotification(BaseDocument* doc, BaseList2D* bl, NOTIFY_EVENT eventid);
	Bool FindEventNotification(BaseDocument* doc, BaseList2D* bl, NOTIFY_EVENT eventid);

	Bool SetDescIDState(const DescID& id, DESCIDSTATE descidstate);
	DESCIDSTATE GetDescIDState(const DescID& id, Bool tolerant) const;

	static BaseList2D* Alloc(Int32 type);
	static void Free(BaseList2D*& bl);
};

GeListHead* AllocListHead();
GeListNode* AllocListNode(Int32 id);
GeListNode* AllocSmallListNode(Int32 id);
GeListNode* AllocMultiNode(Int32* id_array, Int32 id_cnt);
	#define FreeListNode(v) { if (v) C4DOS.Bl.Free(v); v = nullptr; }
	#define blDelete(v)			{ if (v) C4DOS.Bl.Free(v); v = nullptr; }

class BaseLink
{
private:
	BaseLink();
	~BaseLink();

public:
	BaseList2D*		GetLink(const BaseDocument* doc, Int32 instanceof = 0) const { return C4DOS.Ln.GetLink(this, doc, instanceof); }
	C4DAtomGoal*	GetLinkAtom(const BaseDocument* doc, Int32 instanceof = 0) const { return C4DOS.Ln.GetLinkAtom(this, doc, instanceof); }

	BaseList2D*		ForceGetLink() const { return C4DOS.Ln.ForceGetLink(this); }
	C4DAtomGoal*	ForceGetLinkAtom() const { return C4DOS.Ln.ForceGetLinkAtom(this); }

	void SetLink(C4DAtomGoal* list)  { C4DOS.Ln.SetLink(this, list); }

	Bool Read(HyperFile* hf) { return C4DOS.Ln.Read(this, hf); }
	Bool Write(HyperFile* hf) const { return C4DOS.Ln.Write(this, hf); }
	BaseLink*			GetClone(COPYFLAGS flags, AliasTrans* trn) const { return C4DOS.Ln.GetClone(this, flags, trn); }
	Bool CopyTo(BaseLink* dst, COPYFLAGS flags, AliasTrans* trn) const { return C4DOS.Ln.CopyTo(this, dst, flags, trn); }
	Bool IsCacheLink() const { return C4DOS.Ln.IsCacheLink(this); }
	void SetUpPointer(C4DAtom* t_up_pointer) { return C4DOS.Ln.SetUpPointer(this, t_up_pointer); }

	static BaseLink* Alloc();
	static void Free(BaseLink*& link);
};

class AliasTrans
{
private:
	AliasTrans();
	~AliasTrans();

public:
	Bool Init(BaseDocument* doc) { return C4DOS.Ln.TrnInit(this, doc); }
	void Translate(Bool connect_oldgoals) { C4DOS.Ln.TrnTranslate(this, connect_oldgoals); }

	static AliasTrans* Alloc();
	static void	Free(AliasTrans*& link);
};

class BaseSceneLoader : public BaseList2D
{
private:
	BaseSceneLoader();
	~BaseSceneLoader();
};

class BaseSceneSaver  : public BaseList2D
{
private:
	BaseSceneSaver();
	~BaseSceneSaver();
};

void HandleShaderMessage(GeListNode* node, BaseShader* ps, Int32 type, void* data);
void HandleInitialChannel(GeListNode* node, Int32 id, Int32 type, void* data);

Float CalculateTranslationScale(const UnitScaleData* src, const UnitScaleData* dst);
Float CalculateTranslationScale(BaseDocument* sdoc, BaseDocument* ddoc);

#endif	// __API_INTERN__
#endif	// __C4DBASELIST_H
+/