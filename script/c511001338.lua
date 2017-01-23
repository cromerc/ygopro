--Number 1: Infection Buzz King
function c511001338.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001338,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001338.tgcon)
	e1:SetTarget(c511001338.tgtg)
	e1:SetOperation(c511001338.tgop)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12744567,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001338.mttg)
	e2:SetOperation(c511001338.mtop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(31386180,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c511001338.descost)
	e3:SetTarget(c511001338.destg)
	e3:SetOperation(c511001338.desop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511001338.indes)
	c:RegisterEffect(e4)
end
c511001338.xyz_number=1
function c511001338.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
function c511001338.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c511001338.tgop(e,tp,eg,ep,ev,re,r,rp)
	local chk=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	Duel.ConfirmCards(tp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c511001338.mtfilter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_MONSTER)
end
function c511001338.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001338.mtfilter,tp,0,LOCATION_GRAVE,1,nil) end
end
function c511001338.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c511001338.mtfilter,tp,0,LOCATION_GRAVE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Overlay(c,g)
	end
end
function c511001338.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001338.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511001338.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if tc:IsFacedown() or not tc:IsType(TYPE_MONSTER) then
			atk=0
		end
		if Duel.Destroy(tc,REASON_EFFECT)>0 and atk>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
function c511001338.indes(e,c)
	return not c:IsSetCard(0x48)
end
