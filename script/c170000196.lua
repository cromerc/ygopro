--Big Bang Dragon Blow
function c170000196.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,110000110,46232525,1,true,true)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c170000196.target)
	e1:SetOperation(c170000196.operation)
	c:RegisterEffect(e1)
	--Big Bang Attack!
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170000196,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c170000196.cost)
	e2:SetTarget(c170000196.tar)
	e2:SetOperation(c170000196.act)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c170000196.hermos_filter(c)
	return c:IsCode(110000110)
end
function c170000196.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c170000196.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsLocation(LOCATION_SZONE) and tc:IsLocation(LOCATION_MZONE) then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c170000196.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_DRAGON) end
    local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_DRAGON)
	Duel.Release(g,REASON_COST)
end
function c170000196.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c170000196.act(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsFaceup() then return end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end