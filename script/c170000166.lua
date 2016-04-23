--Orichlachos Kytora
function c170000166.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c170000166.spcon)
	e1:SetOperation(c170000166.spop)
	c:RegisterEffect(e1)
    --Negates Battle Damage
   	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c170000166.rdcon)
	e2:SetOperation(c170000166.rdop)
	c:RegisterEffect(e2)
    --special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c170000166.target)
	e3:SetOperation(c170000166.operation)
	c:RegisterEffect(e3)
	
	if not c170000166.global_check then
	c170000166.global_check=true
	c170000166[0]=0
	c170000166[1]=0
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	ge1:SetOperation(c170000166.checkop)
	Duel.RegisterEffect(ge1,0)
end
end
function c170000166.filter(c,e,tp)
	return c:IsCode(170000167) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000166.filter2(c,e,tp)
	return c:IsCode(170000168) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000166.filter3(c,e,tp)
	return c:IsCode(170000169) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000166.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.CheckLPCost(c:GetControler(),500)
end
function c170000166.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,500)
end
function c170000166.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c170000166.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c170000166.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local g2=Duel.SelectMatchingCard(tp,c170000166.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local g3=Duel.SelectMatchingCard(tp,c170000166.filter3,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local tc2=g2:GetFirst()
	local tc3=g3:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
        e1:SetRange(LOCATION_MZONE)
        e1:SetCode(EFFECT_SET_BASE_ATTACK)
        e1:SetValue(c170000166[tp])
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
		tc:CompleteProcedure()
		if tc2 then
		Duel.SpecialSummon(tc2,0,tp,tp,true,false,POS_FACEUP)
		if tc3 then
		Duel.SpecialSummon(tc3,0,tp,tp,true,false,POS_FACEUP)
	end
	end
	end
end
function c170000166.rdcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetAttacker()~=nil and Duel.GetAttackTarget()~=nil
end
function c170000166.rdop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetAttacker()~=nil and Duel.GetAttackTarget()~=nil then
Duel.ChangeBattleDamage(tp,0)
end
end
function c170000166.checkop(e,tp,eg,ep,ev,re,r,rp)
if bit.band(r,REASON_BATTLE)==0 and Duel.GetAttacker()~=nil and Duel.GetAttackTarget()~=nil then
c170000166[ep]=c170000166[ep]+ev
end
end