--Solidroid gamma
function c511002246.initial_effect(c)
	aux.AddFusionProcCode3(c,511002240,511000660,98049038,false,false)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511002246.splimit)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511002246.spcon)
	e2:SetOperation(c511002246.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(16304628,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511002246.destg)
	e3:SetOperation(c511002246.desop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
function c511002246.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511002246.spfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511002246.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<-2 then return false end	
	local g1=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,511002240)
	local g2=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,511000660)
	local g3=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,98049038)
	if g1:GetCount()==0 or g2:GetCount()==0 or g3:GetCount()==0 then return false end
	if ft>0 then return true end
	local f1=g1:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f2=g2:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	local f3=g3:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)>0 and 1 or 0
	if ft==-2 then return f1+f2+f3==3
	elseif ft==-1 then return f1+f2+f3>=2
	else return f1+f2+f3>=1 end
end
function c511002246.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g1=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,511002240)
	local g2=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,511000660)
	local g3=Duel.GetMatchingGroup(c511002246.spfilter,tp,LOCATION_ONFIELD,0,nil,98049038)
	g1:Merge(g2)
	g1:Merge(g3)
	local g=Group.CreateGroup()
	local tc=nil
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		if ft<=0 then
			tc=g1:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=g1:Select(tp,1,1,nil):GetFirst()
		end
		g:AddCard(tc)
		g1:Remove(Card.IsCode,nil,tc:GetCode())
		ft=ft+1
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002246.filter(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c511002246.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511002246.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002246.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002246.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
