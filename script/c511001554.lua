--Ice Rage Shot
function c511001554.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001554.target)
	e1:SetOperation(c511001554.activate)
	c:RegisterEffect(e1)
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_BATTLE_DESTROYING)
	ge1:SetOperation(c511001554.checkop)
	Duel.RegisterEffect(ge1,0)
end
function c511001554.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	if tc:IsFaceup() and bc:IsRace(RACE_AQUA) and bc:GetPreviousControler()==tp then
		tc:RegisterFlagEffect(511001554,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c511001554.filter(c)
	return c:IsFaceup() and c:GetFlagEffect(511001554)>0 and c:IsDestructable()
end
function c511001554.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001554.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001554.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001554.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetAttack())
end
function c511001554.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,tc:GetPreviousAttackOnField(),REASON_EFFECT)
	end
end
