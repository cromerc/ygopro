--Solidroid α
function c511002244.initial_effect(c)
	aux.AddFusionProcCode3(c,511000660,98049038,511002240,false,false)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511002244.spcon)
	e2:SetOperation(c511002244.spop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(16304628,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c511002244.atkop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
function c511002244.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511002244.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local g1=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,98049038)
	local g2=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,511002240)
	local g3=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,511000660)
	if g1:GetCount()==0 or g2:GetCount()==0 or g3:GetCount()==0 then return false end
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c511002244.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,98049038)
	local g2=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,511002240)
	local g3=Duel.GetMatchingGroup(c511002244.cfilter,tp,LOCATION_HAND,0,nil,511000660)
	g1:Merge(g2)
	g1:Merge(g3)
	local g=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tc=g1:Select(tp,1,1,nil):GetFirst()
		g:AddCard(tc)
		g1:Remove(Card.IsCode,nil,tc:GetCode())
	end
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002244.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local atk=tc:GetBaseAttack()
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
