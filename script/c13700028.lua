-- The Necloth of Gungnir
function c13700028.initial_effect(c)	
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c13700028.splimit)
	c:RegisterEffect(e1)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,13700028)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCost(c13700028.cost)
	e1:SetTarget(c13700028.target)
	e1:SetOperation(c13700028.activate)
	c:RegisterEffect(e1)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DEFCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1,137000282)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c13700028.dcost)
	e3:SetTarget(c13700028.dtarget)
	e3:SetOperation(c13700028.doperation)
	c:RegisterEffect(e3)
end
function c13700028.mat_filter(c)
	return c:GetLevel()~=7
end
function c13700028.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsCode(13700028) then
		local clv=c:GetLevel()
		return 99 
	else return lv end
end
function c13700028.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end

function c13700028.costfilter(c)
	return c:IsSetCard(0xb4) and c:IsDiscardable()
end
function c13700028.filter1(c)
	return c:IsDestructable()
end
function c13700028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700028.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c13700028.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c13700028.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c13700028.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13700028.filter1,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c13700028.filter1,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c13700028.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

function c13700028.dcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c13700028.filter(c)
	return c:IsSetCard(0xb4) and c:IsFaceup()
end
function c13700028.dtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c13700028.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13700028.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPDEFENCE)
	Duel.SelectTarget(tp,c13700028.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13700028.doperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e3)
	end
end
