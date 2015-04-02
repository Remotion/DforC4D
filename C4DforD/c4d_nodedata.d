/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////

module c4d_nodedata;

import c4d;
import c4d_os;

public import c4d_general;
public import c4d_basedata;

import c4d_baselist : C4DAtom,GeListNode;


//=============================================================================
class NodeData : BaseData
{
protected:
	GeListNode* private_link = null;

public:
	this()   { /*printf("NodeData.this >\n");*/ }
	~this()  { /*printf("NodeData.~this <\n");*/ }

	const(GeListNode)* Get() const { return private_link; }


	Bool Init(GeListNode* node){ return true; }
	void Free(GeListNode* node){  }
	Bool Read(GeListNode* node, HyperFile* hf, Int32 level){ return true; }
	Bool Write(GeListNode* node, HyperFile* hf){ return true; }
	Bool Message(GeListNode* node, Int32 type, void* data){ return true; }
	Bool CopyTo(NodeData* dest, GeListNode* snode, GeListNode* dnode, COPYFLAGS flags, AliasTrans* trn){ return true; }
	void GetBubbleHelp(GeListNode* node,ref String str){  }
	BaseDocument* GetDocument(GeListNode* node){ return null; }
	Int32 GetBranchInfo(GeListNode* node, BranchInfo* info, Int32 max, GETBRANCHINFO flags){ return 0; }
	Bool IsInstanceOf(const GeListNode* node, Int32 type) const{ return false; }

	Bool GetDDescription(GeListNode* node, Description* description, ref DESCFLAGS_DESC  flags){ return false; }
	Bool GetDParameter(GeListNode* node, ref const DescID  id, ref GeData  t_data, ref DESCFLAGS_GET  flags){ return true; }
	Bool GetDEnabling(GeListNode* node, ref const DescID  id, ref const GeData  t_data, DESCFLAGS_ENABLE flags, const BaseContainer* itemdesc){ return true; }
	Bool SetDParameter(GeListNode* node, ref const DescID  id, ref const GeData  t_data, ref DESCFLAGS_SET  flags){ return true; }
	Bool TranslateDescID(GeListNode* node, ref const DescID  id, ref DescID  res_id, ref C4DAtom*  res_at){ return false; }
	Bool IsDocumentRelated(const GeListNode* node, ref Bool  docrelated) const{ return false; }

};


Bool RegisterNodePlugin(Int32 id,ref const String str, Int32 info, DataAllocator g, BaseBitmap* icon, Int32 disklevel, Int32* fallback)
{
	NODEPLUGIN np;
	ClearMem(&np, (np.sizeof));
	FillNodePlugin(&np, info, g, icon, disklevel);
	np.fallback = fallback;
	return GeRegisterPlugin(PLUGINTYPE_NODE, id, str, &np, (np.sizeof));
}

// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF
// INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF -- INTERNAL STUFF

//? alias NodeData*   DataAllocator();
alias DataAllocator = extern (C++) NodeData function(); //TODO ??
//alias DataAllocator = NodeData; //???


extern (C++) 
struct NODEPLUGIN //: BASEPLUGIN
{
	BASEPLUGIN parent; //?
	alias parent this; //? 


	Int32					disklevel;
	String*					name;
	void*					emulation;
	Int32*					fallback;
	BaseBitmap*				icon;

	NodeData				function() Allocator; // NodeData* !?!?!?

	Bool					function(NodeData self,GeListNode *node)  Init;
	void					function(NodeData self,GeListNode *node)  Free;
	Bool					function(NodeData self,GeListNode *node, HyperFile *hf, Int32 level)  Read;
	Bool					function(NodeData self,GeListNode *node, HyperFile *hf)  Write;
	Bool					function(NodeData self,NodeData *dest, GeListNode *snode, GeListNode *dnode, COPYFLAGS flags, AliasTrans *trn)  CopyTo;
	Bool					function(NodeData self,GeListNode *node, Int32 type, void *data)  Message;
	BaseDocument*			function(NodeData self,GeListNode *node)  GetDocument;
	void					function(NodeData self,GeListNode *node, ref String  str)  GetBubbleHelp;
	Bool					function(NodeData self,GeListNode *node, Description *description, ref DESCFLAGS_DESC  flags)  GetDDescription;
	Bool					function(NodeData self,GeListNode *node, ref const DescID  id, ref GeData  t_data, ref DESCFLAGS_GET  flags)  GetDParameter;
	Bool					function(NodeData self,GeListNode *node, ref const DescID  id, ref const GeData  t_data, ref DESCFLAGS_SET  flags)  SetDParameter;
	Bool					function(NodeData self,GeListNode *node, ref const DescID  id, ref const GeData  t_data, DESCFLAGS_ENABLE flags, const BaseContainer *itemdesc)  GetDEnabling;
	Bool					function(const NodeData self,const GeListNode *node, Int32 type)  IsInstanceOf ;
	Int32					function(NodeData self,GeListNode *node, BranchInfo *info, Int32 max, GETBRANCHINFO flags)  GetBranchInfo;
	Bool					function(NodeData self,GeListNode *node, ref const DescID  id, ref DescID  res_id, ref C4DAtom * res_at)  TranslateDescID;
	Bool					function(const NodeData self,const GeListNode *node, ref Bool  docrelated)  IsDocumentRelated ;

	void*					reserved[(32-16)*C4DPL_MEMBERMULTIPLIER-6];
};


void FillNodePlugin(NODEPLUGIN* np, Int32 info, DataAllocator g, BaseBitmap* icon, Int32 disklevel, void* emulation = null)
{
	np.Allocator			= g;

	np.Destructor			= function(BaseData self ){ self.Destructor();		};			
	np.Init					= function(NodeData self, GeListNode *node){ return self.Init(node);		};	
	np.Free					= function(NodeData self, GeListNode *node){		self.Free(node);		};
	np.Read					= function(NodeData self, GeListNode *node, HyperFile *hf, Int32 level){ return self.Read(node,hf,level);			};
	np.Write				= function(NodeData self, GeListNode *node, HyperFile *hf){ return self.Write(node,hf);			};
	np.CopyTo				= function(NodeData self, NodeData *dest, GeListNode *snode, GeListNode *dnode, COPYFLAGS flags, AliasTrans *trn){ return self.CopyTo(dest,snode,dnode,flags,trn);	};
	np.Message				= function(NodeData self, GeListNode *node, Int32 type, void *data){ return self.Message(node,type,data);		};
	np.GetDocument			= function(NodeData self, GeListNode *node){ return self.GetDocument(node);			};
	np.GetBubbleHelp		= function(NodeData self, GeListNode *node, ref String  str){	self.GetBubbleHelp(node,str);		};
	np.GetDDescription		= function(NodeData self, GeListNode *node, Description *description, ref DESCFLAGS_DESC  flags){ return self.GetDDescription(node,description,flags);		};
	np.GetDParameter		= function(NodeData self, GeListNode *node, ref const DescID  id, ref GeData  t_data, ref DESCFLAGS_GET  flags){ return self.GetDParameter(node,id,t_data,flags);		};
	np.SetDParameter		= function(NodeData self, GeListNode *node, ref const DescID  id, ref const GeData  t_data, ref DESCFLAGS_SET  flags){ return self.SetDParameter(node,id,t_data,flags);		};
	np.GetDEnabling			= function(NodeData self, GeListNode *node, ref const DescID  id, ref const GeData  t_data, DESCFLAGS_ENABLE flags, const BaseContainer *itemdesc){ return self.GetDEnabling(node,id,t_data,flags,itemdesc); };
	np.IsInstanceOf			= function(const NodeData self,const GeListNode *node, Int32 type){ return self.IsInstanceOf(node,type);		};	
	np.GetBranchInfo		= function(NodeData self, GeListNode *node, BranchInfo *info, Int32 max, GETBRANCHINFO flags){ return self.GetBranchInfo(node,info,max,flags);		};
	np.TranslateDescID		= function(NodeData self, GeListNode *node, ref const DescID  id, ref DescID  res_id, ref C4DAtom * res_at){ return self.TranslateDescID(node,id,res_id,res_at);		};
	np.IsDocumentRelated	= function(const NodeData self,const GeListNode *node, ref Bool  docrelated){ return self.IsDocumentRelated(node,docrelated);	};

	/+
	np.Destructor			= &NodeData::Destructor;
	np.Init					= &NodeData::Init;
	np.Free					= &NodeData::Free;
	np.Read					= &NodeData::Read;
	np.Write				= &NodeData::Write;
	np.CopyTo				= &NodeData::CopyTo;
	np.Message				= &NodeData::Message;
	np.GetDocument			= &NodeData::GetDocument;
	np.GetBranchInfo		= &NodeData::GetBranchInfo;
	np.GetDDescription		= &NodeData::GetDDescription;
	np.GetDParameter		= &NodeData::GetDParameter;
	np.SetDParameter		= &NodeData::SetDParameter;
	np.GetDEnabling			= &NodeData::GetDEnabling;
	np.GetBubbleHelp		= &NodeData::GetBubbleHelp;
	np.IsInstanceOf			= &NodeData::IsInstanceOf;
	np.TranslateDescID		= &NodeData::TranslateDescID;
	np.IsDocumentRelated	= &NodeData::IsDocumentRelated;
	+/

	np.disklevel	= disklevel;
	np.info			= info;
	np.icon			= icon;
	np.emulation	= emulation;
	np.fallback		= null;
}


/+
#ifndef C4D_NODEDATA_H__
#define C4D_NODEDATA_H__

#include "c4d_basedata.h"
#include "ge_prepass.h"

class C4DAtom;
class GeListNode;
class HyperFile;
class AliasTrans;
class BaseDocument;
class String;
class Description;
class DescID;
class GeData;
class BaseContainer;
class BaseBitmap;
struct NODEPLUGIN;
struct BranchInfo;

class NodeData : public BaseData
{
protected:
	GeListNode* private_link;

public:
	GeListNode* Get(void) const { return private_link; }

	virtual Bool Init(GeListNode* node);
	virtual void Free(GeListNode* node);
	virtual Bool Read(GeListNode* node, HyperFile* hf, Int32 level);
	virtual Bool Write(GeListNode* node, HyperFile* hf);
	virtual Bool Message(GeListNode* node, Int32 type, void* data);
	virtual Bool CopyTo(NodeData* dest, GeListNode* snode, GeListNode* dnode, COPYFLAGS flags, AliasTrans* trn);
	virtual void GetBubbleHelp(GeListNode* node, String& str);
	virtual BaseDocument* GetDocument(GeListNode* node);
	virtual Int32 GetBranchInfo(GeListNode* node, BranchInfo* info, Int32 max, GETBRANCHINFO flags);
	virtual Bool IsInstanceOf(const GeListNode* node, Int32 type) const;

	virtual Bool GetDDescription(GeListNode* node, Description* description, DESCFLAGS_DESC& flags);
	virtual Bool GetDParameter(GeListNode* node, const DescID& id, GeData& t_data, DESCFLAGS_GET& flags);
	virtual Bool GetDEnabling(GeListNode* node, const DescID& id, const GeData& t_data, DESCFLAGS_ENABLE flags, const BaseContainer* itemdesc);
	virtual Bool SetDParameter(GeListNode* node, const DescID& id, const GeData& t_data, DESCFLAGS_SET& flags);
	virtual Bool TranslateDescID(GeListNode* node, const DescID& id, DescID& res_id, C4DAtom*& res_at);
	virtual Bool IsDocumentRelated(const GeListNode* node, Bool& docrelated) const;
};

typedef NodeData* DataAllocator (void);

void FillNodePlugin(NODEPLUGIN* np, Int32 info, DataAllocator* g, BaseBitmap* icon, Int32 disklevel, void* emulation = nullptr);
Bool RegisterNodePlugin(Int32 id, const String& str, Int32 info, DataAllocator* g, BaseBitmap* icon, Int32 disklevel, Int32* fallback);

#endif // C4D_NODEDATA_H__
+/