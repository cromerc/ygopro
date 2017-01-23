--No.9 天蓋星ダイソン・スフィア (Anime)
function c511010009.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2)
	c:EnableReviveLimit()
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010009,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_BATTLE_PHASE)
	e1:SetCondition(c511010009.atkcon)
	e1:SetCost(c511010009.atkcost)
	e1:SetOperation(c511010009.atkop)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511010009,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c511010009.olcon)
	e2:SetTarget(c511010009.oltg)
	e2:SetOperation(c511010009.olop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511010009,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511010009.dacon)
	e3:SetCost(c511010009.dacost)
	e3:SetOperation(c511010009.daop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010009.indes)
	c:RegisterEffect(e6)
	if not c511010009.global_check then
		c511010009.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010009.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010009.xyz_number=9
function c511010009.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget()
end
function c511010009.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511010009)==0 end
	e:GetHandler():RegisterFlagEffect(511010009,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c511010009.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511010009.olcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0 and e:GetHandler():IsType(TYPE_XYZ)
end
function c511010009.oltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsType(TYPE_MONSTER) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,2,nil,TYPE_MONSTER) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,2,2,nil,TYPE_MONSTER)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,2,0,0)
end
function c511010009.olop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
	end
end
function c511010009.dafilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511010009.dacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
		and Duel.IsExistingMatchingCard(c511010009.dafilter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end
function c511010009.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010009.daop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c511010009.dafilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511010009.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,1992816)
	Duel.CreateToken(1-tp,1992816)
end
function c511010009.indes(e,c)
return not c:IsSetCard(0x48)
end