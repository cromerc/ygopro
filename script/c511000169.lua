--Tribute Burial
function c511000169.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000169.target)
	e1:SetOperation(c511000169.activate)
	c:RegisterEffect(e1)
end
function c511000169.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511000169.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000169.rmfilter,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.IsExistingTarget(c511000169.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,c511000169.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,c511000169.rmfilter,tp,0,LOCATION_GRAVE,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,g1:GetCount(),0,0)
end
function c511000169.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		--summon with no tribute
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(511000169,0))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetTargetRange(LOCATION_HAND,0)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetRange(LOCATION_GRAVE+LOCATION_REMOVED)
		e1:SetCondition(c511000169.ntcon)
		e1:SetTarget(c511000169.nttg)
		e1:SetOperation(c511000169.ntop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511000169.ntcon(e,c)
	if e:GetHandler():GetFlagEffect(511000169)~=0 then return false end
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511000169.nttg(e,c)
	return c:IsLevelAbove(5)
end
function c511000169.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	e:GetHandler():RegisterFlagEffect(511000169,RESET_EVENT+0x1fe0000,0,1)
end
