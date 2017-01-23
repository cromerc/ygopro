--Bee Force - Hama the Devil Conquering Bow
function c511001949.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsSetCard,0x214),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100009,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001949.atcon)
	e1:SetTarget(c511001949.attg)
	e1:SetOperation(c511001949.atop)
	c:RegisterEffect(e1)
	--attack twice
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95100009,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511001949.damcon)
	e3:SetTarget(c511001949.damtg)
	e3:SetOperation(c511001949.damop)
	c:RegisterEffect(e3)
	if not c511001949.global_check then
		c511001949.global_check=true
		c511001949[0]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511001949.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001949.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001949.atcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511001949.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511001949.atop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-ev)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
end
function c511001949.damcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetTurnPlayer()==tp and c511001949[0]
end
function c511001949.filter(c)
	return c:IsSetCard(0x214) and c:IsType(TYPE_MONSTER)
end
function c511001949.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001949.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c511001949.filter,tp,LOCATION_GRAVE,0,nil)*300
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001949.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(c511001949.filter,tp,LOCATION_GRAVE,0,nil)*300
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001949.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511001949[0]=false
end
function c511001949.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001949[0]=true
end
