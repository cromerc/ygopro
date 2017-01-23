--Natural Selection
function c511000370.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000370.condition)
	e1:SetTarget(c511000370.target)
	e1:SetOperation(c511000370.activate)
	c:RegisterEffect(e1)
end
function c511000370.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000370.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511000370.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511000370.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000370.filter,tp,0,LOCATION_MZONE,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,511000371,0,nil,nil,nil,nil,nil,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000370.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000370.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local token=Duel.CreateToken(tp,511000371)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0xfe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		e2:SetValue(tc:GetDefense())
		token:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetLevel())
		token:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(tc:GetRace())
		token:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(tc:GetAttribute())
		token:RegisterEffect(e5)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetTarget(c511000370.destg)
		e2:SetOperation(c511000370.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e2)
	end
end
function c511000370.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511000370.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
