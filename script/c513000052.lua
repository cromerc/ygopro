--究極時械神セフィロン
function c513000052.initial_effect(c)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c513000052.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8967776,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c513000052.sptg)
	e2:SetOperation(c513000052.spop)
	c:RegisterEffect(e2)
	--attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c513000052.atkval)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetOperation(c513000052.disop)
	c:RegisterEffect(e4)
	--0 damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetCondition(c513000052.damcon)
	e5:SetOperation(c513000052.damop)
	c:RegisterEffect(e5)
	--
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_CHAIN_SOLVING)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c513000052.damcon2)
	e6:SetOperation(c513000052.damop)
	c:RegisterEffect(e6)
end
function c513000052.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(100000014)
end
function c513000052.filter(c,e,tp)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c513000052.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000052.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c513000052.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000052.filter,tp,0x13,0,ft,ft,nil,e,tp)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK)
		e3:SetValue(4000)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c513000052.cfilter(c)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899)) and c:IsFaceup()
end
function c513000052.atkval(e,c)
	local g=Duel.GetMatchingGroup(c513000052.cfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetAttack)
end
function c513000052.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
	end
end
function c513000052.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc or c:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then return false end
	if bc==Duel.GetAttackTarget() and bc:IsDefensePos() then return false end
	if c:IsAttackPos() and bc:IsDefensePos() and bc:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 
		and c:GetAttack()<=bc:GetDefense() then return true end
	if c:IsAttackPos() and (bc:IsAttackPos() or bc:IsHasEffect(EFFECT_DEFENSE_ATTACK)) 
		and c:GetAttack()<=bc:GetAttack() then return true end
	if c:IsDefensePos() and bc:IsDefensePos() and bc:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 
		and c:GetDefense()<bc:GetDefense() then return true end
	if c:IsDefensePos() and (bc:IsAttackPos() or bc:IsHasEffect(EFFECT_DEFENSE_ATTACK)) 
		and c:GetDefense()<bc:GetAttack() then return true end
	return false
end
function c513000052.repfilter(c)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) and c:IsAbleToRemove()
end
function c513000052.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if (e:GetCode()~=EVENT_PRE_DAMAGE_CALCULATE or c:IsRelateToBattle()) and Duel.IsExistingMatchingCard(c513000052.repfilter,tp,LOCATION_MZONE,0,1,c) 
		and Duel.SelectYesNo(tp,aux.Stringid(40945356,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c513000052.repfilter,tp,LOCATION_MZONE,0,1,1,c)
		Duel.Remove(g,POS_FACEUP,REASON_REPLACE+REASON_EFFECT)
		if e:GetCode()==EVENT_PRE_DAMAGE_CALCULATE then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
			e1:SetOperation(c513000052.damopx)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
			Duel.RegisterEffect(e1,tp)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e2:SetValue(1)
			e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
			c:RegisterEffect(e2)
		else
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e3:SetValue(1)
			e3:SetReset(RESET_CHAIN)
			c:RegisterEffect(e3)
		end
	end
end
function c513000052.damopx(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c513000052.damcon2(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if tg==nil then return false end
	return ex and tg:IsContains(e:GetHandler()) and tc+1-tg:GetCount()==1
end
