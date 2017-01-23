--E・HERO ゴッド・ネオス
function c511001645.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511001645.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511001645.spcon)
	e2:SetOperation(c511001645.spop)
	c:RegisterEffect(e2)
	--copy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(31111109,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c511001645.copycost)
	e3:SetOperation(c511001645.copyop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c511001645.atkval)
	c:RegisterEffect(e4)
end
function c511001645.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511001645.spfilter(c)
	return c:IsAbleToDeckOrExtraAsCost() and c:IsCode(89943723)
end
function c511001645.spfilter2(c)
	return c:IsAbleToDeckOrExtraAsCost() and c:IsSetCard(0x1f)
end
function c511001645.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<0 then return false end
	local g=Duel.GetMatchingGroup(c511001645.spfilter,tp,LOCATION_ONFIELD,0,nil)
	local nsg=Duel.GetMatchingGroup(c511001645.spfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	if g:GetCount()==0 or nsg:GetClassCount(Card.GetCode)<=5 then return false end
	if ft>0 then return true end
	local f1=g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f2=nsg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	if ft==-2 then return f1+f2==3
	elseif ft==-1 then return f1+f2>=2
	else return f1+f2>=1 end
end
function c511001645.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c511001645.spfilter,tp,LOCATION_ONFIELD,0,nil)
	local nsg=Duel.GetMatchingGroup(c511001645.spfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	g:Merge(nsg)
	local rg=Group.CreateGroup()
	local tc=nil
	for i=1,7 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		if i==1 then
			tc=g:FilterSelect(tp,Card.IsCode,1,1,nil,89943723):GetFirst()
		elseif ft<=0 then
			tc=g:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=g:Select(tp,1,1,nil):GetFirst()
		end
		if tc then
			rg:AddCard(tc)
			g:Remove(Card.IsCode,nil,tc:GetCode())
		end
		rg:AddCard(tc)
		g:Remove(Card.IsCode,nil,tc:GetCode())
		ft=ft+1
	end
	local cg=rg:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(rg,nil,2,REASON_COST)
end
function c511001645.copyfilter(c)
	return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER)
		and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemoveAsCost()
end
function c511001645.copycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001645.copyfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001645.copyfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:GetFirst():RegisterFlagEffect(511001645,RESET_EVENT+0x1fe0000,0,1)
	e:SetLabelObject(g:GetFirst())
end
function c511001645.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc then
		local code=tc:GetOriginalCode()
		local cid=c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(31111109,1))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetLabel(cid)
		e1:SetOperation(c511001645.rstop)
		c:RegisterEffect(e1)
	end
end
function c511001645.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c511001645.atkfilter(c)
	return c:GetFlagEffect(511001645)>0
end
function c511001645.atkval(e,c)
	return Duel.GetMatchingGroupCount(c511001645.atkfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*500
end
