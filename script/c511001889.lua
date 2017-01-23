--Aura Armor
function c511001889.initial_effect(c)
	--end battle phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18964575,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001889.condition)
	e1:SetTarget(c511001889.target)
	e1:SetOperation(c511001889.activate)
	c:RegisterEffect(e1)
end
function c511001889.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil and Duel.GetLP(tp)<=2000
end
function c511001889.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001890,0,0x4011,-2,-2,4,RACE_WARRIOR,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001889.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001890,0,0x4011,-2,-2,4,RACE_WARRIOR,ATTRIBUTE_EARTH) then return end
	if Duel.NegateAttack() then
		local token=Duel.CreateToken(tp,511001890)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(c511001889.val)
		e1:SetReset(RESET_EVENT+0xfe0000)
		token:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE)
		e2:SetValue(c511001889.val)
		e2:SetReset(RESET_EVENT+0xfe0000)
		token:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_SPSUMMON_SUCCESS)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetReset(RESET_EVENT+0x0fe0000)
		e3:SetOperation(c511001889.sumop)
		token:RegisterEffect(e3)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001889.val(e,c)
	return Duel.GetLP(e:GetHandler():GetOwner())
end
function c511001889.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,Duel.GetLP(tp)/2)
end
