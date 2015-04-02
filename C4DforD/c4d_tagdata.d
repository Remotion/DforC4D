/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////
module c4d_tagdata;

import c4d;
import c4d_os;

public import c4d_nodedata;

//struct BaseTag;
//struct BaseObject;


//=============================================================================
class TagData :  NodeData
{
public:
	////inherited from NodeData////
	//virtual Bool Init(GeListNode *node);
	//virtual void Free(GeListNode *node);
	//virtual Bool Read(GeListNode *node, HyperFile *hf, Int32 level);
	//virtual Bool Write(GeListNode *node, HyperFile *hf);
	//virtual Bool Message(GeListNode *node, Int32 type, void *data);
	//virtual Bool CopyTo(NodeData *dest, GeListNode *snode, GeListNode *dnode, COPYFLAGS flags, AliasTrans *trn);
	//virtual void GetBubbleHelp(GeListNode *node, String &str);
	//virtual BaseDocument* GetDocument(GeListNode *node);
	//virtual Int32 GetBranchInfo(GeListNode *node, BranchInfo *info, Int32 max, GETBRANCHINFO flags);
	//virtual Bool GetDDescription(GeListNode *node, Description *description, DESCFLAGS_DESC &flags);
	//virtual Bool GetDParameter(GeListNode *node, const DescID &id,GeData &t_data,DESCFLAGS_GET &flags);
	//virtual Bool GetDEnabling(GeListNode *node, const DescID &id,const GeData &t_data,DESCFLAGS_ENABLE flags,const BaseContainer *itemdesc);
	//virtual Bool SetDParameter(GeListNode *node, const DescID &id,const GeData &t_data,DESCFLAGS_SET &flags);
	//static NodeData *Alloc(void) { return NewObjClear(MyNodeData); }
	////inherited from NodeData////

	
	Bool Draw(BaseTag* tag, BaseObject* op, BaseDraw* bd, BaseDrawHelp* bh){	return true;	}
	EXECUTIONRESULT Execute(BaseTag* tag, BaseDocument* doc, BaseObject* op, BaseThread* bt, Int32 priority, EXECUTIONFLAGS flags){ return EXECUTIONRESULT_OK; }
	Bool AddToExecution(BaseTag* tag, PriorityList* list){ return false; }
	Bool GetModifiedObjects(BaseTag* tag, BaseDocument* doc, ref BaseObject*  op, ref Bool  pluginownedop, ref const Matrix  op_mg, Float lod, Int32 flags, BaseThread* thread) {	return true;	}
	
};

import c4d_resource : RegisterDescription;

Bool RegisterTagPlugin(Int32 id, in String  str, Int32 info, DataAllocator npalloc, in String  description, BaseBitmap* icon, Int32 disklevel)
{
	if (description.Content() && !RegisterDescription(id, description))
		return false;

	TAGPLUGIN np;
	ClearMem(&np, np.sizeof);
	FillTagPlugin(&np, npalloc, info, disklevel, icon);
	return GeRegisterPlugin(PLUGINTYPE_TAG, id, str, &np, np.sizeof);
}

// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF

extern (C++) 
struct TAGPLUGIN //: public NODEPLUGIN
{
	NODEPLUGIN parent; //?
	alias parent this; //? 


	Bool				function(TagData self, BaseTag *tag, BaseObject *op, BaseDraw *bd, BaseDrawHelp *bh)Draw;
	EXECUTIONRESULT		function(TagData self, BaseTag *tag, BaseDocument *doc, BaseObject *op, BaseThread *bt, Int32 priority, EXECUTIONFLAGS flags)Execute;
	Bool				function(TagData self, BaseTag *tag, PriorityList *list)AddToExecution;
	Bool				function(TagData self, BaseTag *tag, GeClipMap *map)GetOmanagerIconEx;
	Bool				function(TagData self, BaseTag *tag, BaseDocument *doc, ref BaseObject * op, ref Bool  pluginownedop, ref const Matrix  op_mg, Float lod, Int32 flags, BaseThread *thread)GetModifiedObjects;

	void*	reserved[(32-5)*C4DPL_MEMBERMULTIPLIER-0];
};

static void FillTagPlugin(TAGPLUGIN* np, DataAllocator npalloc, Int32 info, Int32 disklevel, BaseBitmap* icon)
{
	FillNodePlugin(cast(NODEPLUGIN*)np, info, npalloc, icon, disklevel, null);

	np.Draw					= function(TagData self, BaseTag *tag, BaseObject *op, BaseDraw *bd, BaseDrawHelp *bh) {
		//printf(" Draw %p %p \n",self,tag);
		return self.Draw(tag,op,bd,bh);
	};
	
	np.Execute				= function(TagData self, BaseTag *tag, BaseDocument *doc, BaseObject *op, BaseThread *bt, Int32 priority, EXECUTIONFLAGS flags)
	{ return self.Execute(tag,doc,op,bt,priority,flags); };
	
	np.AddToExecution		= function(TagData self, BaseTag *tag, PriorityList *list)
	{ return self.AddToExecution(tag,list); };
	
	np.GetModifiedObjects	= function(TagData self, BaseTag *tag, BaseDocument *doc, ref BaseObject *op, ref Bool  pluginownedop, ref const Matrix  op_mg, Float lod, Int32 flags, BaseThread *thread)
	{ return self.GetModifiedObjects(tag,doc,op,pluginownedop,op_mg,lod,flags,thread); };


	//np->Draw = &TagData::Draw;
	//np->Execute	= &TagData::Execute;
	//np->AddToExecution = &TagData::AddToExecution;
	//np->GetModifiedObjects = &TagData::GetModifiedObjects;
}





/+
#ifndef C4D_TAGDATA_H__
#define C4D_TAGDATA_H__

#include "c4d_nodedata.h"
#include "operatingsystem.h"

class BaseTag;
class BaseObject;
class BaseDraw;
class BaseDrawHelp;
class BaseDocument;
class BaseBitmap;
class String;
class BaseThread;
class PriorityList;
class GeClipMap;

class TagData : public NodeData
{
public:
	////inherited from NodeData////
	//virtual Bool Init(GeListNode *node);
	//virtual void Free(GeListNode *node);
	//virtual Bool Read(GeListNode *node, HyperFile *hf, Int32 level);
	//virtual Bool Write(GeListNode *node, HyperFile *hf);
	//virtual Bool Message(GeListNode *node, Int32 type, void *data);
	//virtual Bool CopyTo(NodeData *dest, GeListNode *snode, GeListNode *dnode, COPYFLAGS flags, AliasTrans *trn);
	//virtual void GetBubbleHelp(GeListNode *node, String &str);
	//virtual BaseDocument* GetDocument(GeListNode *node);
	//virtual Int32 GetBranchInfo(GeListNode *node, BranchInfo *info, Int32 max, GETBRANCHINFO flags);
	//virtual Bool GetDDescription(GeListNode *node, Description *description, DESCFLAGS_DESC &flags);
	//virtual Bool GetDParameter(GeListNode *node, const DescID &id,GeData &t_data,DESCFLAGS_GET &flags);
	//virtual Bool GetDEnabling(GeListNode *node, const DescID &id,const GeData &t_data,DESCFLAGS_ENABLE flags,const BaseContainer *itemdesc);
	//virtual Bool SetDParameter(GeListNode *node, const DescID &id,const GeData &t_data,DESCFLAGS_SET &flags);
	//static NodeData *Alloc(void) { return NewObjClear(MyNodeData); }
	////inherited from NodeData////

	virtual Bool Draw(BaseTag* tag, BaseObject* op, BaseDraw* bd, BaseDrawHelp* bh);
	virtual EXECUTIONRESULT Execute(BaseTag* tag, BaseDocument* doc, BaseObject* op, BaseThread* bt, Int32 priority, EXECUTIONFLAGS flags);
	virtual Bool AddToExecution(BaseTag* tag, PriorityList* list);
	virtual Bool GetModifiedObjects(BaseTag* tag, BaseDocument* doc, BaseObject*& op, Bool& pluginownedop, const Matrix& op_mg, Float lod, Int32 flags, BaseThread* thread);
};

Bool RegisterTagPlugin(Int32 id, const String& str, Int32 info, DataAllocator* g, const String& description, BaseBitmap* icon, Int32 disklevel);

#endif // C4D_TAGDATA_H__



+/