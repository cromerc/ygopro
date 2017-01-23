--Orichalcos Shunoros (Anime)
function c170000167.initial_effect(c)
	c:EnableReviveLimit()
	--cannot summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--ATK goes down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c170000167.statcon)
	e2:SetOperation(c170000167.statop)
	c:RegisterEffect(e2)
	--DEF goes down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c170000167.statcon2)
	e3:SetOperation(c170000167.statop2)
	c:RegisterEffect(e3)
	--DIVINE SERPENT
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetCondition(c170000167.dscon)
	e4:SetTarget(c170000167.dstg)
	e4:SetOperation(c170000167.dsop)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(170000166)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c170000167.atkop)
	c:RegisterEffect(e5)
	--sp summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(62892347,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetTarget(c170000167.sptg)
	e6:SetOperation(c170000167.spop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)
	local e8=e6:Clone()
	e8:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e8)
end
function c170000167.statcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc==nil then return false end
	return bc:GetPosition()==POS_FACEUP_ATTACK or bc:GetPosition()==POS_FACEDOWN_ATTACK
end
function c170000167.statop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local atk=bc:GetAttack()
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-atk)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e1)
end
function c170000167.statcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if bc==nil then return false end
	return bc:GetPosition()==POS_FACEUP_DEFENSE or bc:GetPosition()==POS_FACEDOWN_DEFENSE
end
function c170000167.statop2(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local def=bc:GetDefense()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-def)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e1)
end
function c170000167.dscon(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local crp=c:GetReasonPlayer()
	return c:IsReason(REASON_DESTROY) and  e:GetHandler():GetPreviousAttackOnField()==0 and Duel.GetLP(tp)>=10000
end
function c170000167.filter(c,e,tp)
	return c:IsCode(82103466) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000167.dstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c170000167.dsop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c170000167.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c170000167.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end
function c170000167.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c170000167.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,170000168) 
		and Duel.IsExistingMatchingCard(c170000167.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,170000169) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK+LOCATION_HAND)
end
function c170000167.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000167.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g1=Duel.GetMatchingGroup(c170000167.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,170000168)
	local g2=Duel.GetMatchingGroup(c170000167.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,170000169)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		local tc=sg1:GetFirst()
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		Duel.SpecialSummonStep(sg2:GetFirst(),0,tp,tp,true,false,POS_FACEUP)
		Duel.SpecialSummonComplete()
	end
end
