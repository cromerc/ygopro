-- Impact Flip
-- scripted by: UnknownGuest
function c810000007.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c810000007.target)
	e1:SetOperation(c810000007.operation)
	c:RegisterEffect(e1)
	-- send the top card
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c810000007.ddcon)
	e2:SetOperation(c810000007.ddop)
	c:RegisterEffect(e2)
	-- Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c810000007.eqlimit)
	c:RegisterEffect(e3)
	-- flip 1 monster
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(810000007,0))
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c810000007.fliptg)
	e4:SetOperation(c810000007.flipop)
	c:RegisterEffect(e4)
	-- both player draws
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c810000007.drawcon)
	e5:SetTarget(c810000007.drawtg)
	e5:SetOperation(c810000007.drawop)
	c:RegisterEffect(e5)
end
function c810000007.eqlimit(e,c)
	return c:IsFaceup()
end
function c810000007.filter(c)
	return c:IsFaceup()
end
function c810000007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c810000007.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c810000007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c810000007.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c810000007.ddcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	local bc=ec:GetBattleTarget()
	return ec and eg:IsContains(ec) and bc:IsReason(REASON_BATTLE)
end
function c810000007.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
end
function c810000007.flipfilter(c)
	return c:IsPosition(POS_FACEDOWN_DEFENSE)
end
function c810000007.fliptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:IsFacedown() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c810000007.flipfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectTarget(tp,c810000007.flipfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c810000007.flipop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ChangePosition(tc,0x1,0x1,0x4,0x4,true)
	end
end
function c810000007.drawcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c810000007.drawtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c810000007.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end