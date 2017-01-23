--Orichalchos Kyutora
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
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
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
	e3:SetLabel(0)
	c:RegisterEffect(e3)
	e2:SetLabelObject(e3)
	--avoid battle damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c170000166.efilter)
	e4:SetValue(1)
	c:RegisterEffect(e4)
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
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingMatchingCard(c170000166.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c170000166.filter(c,e,tp)
	return c:IsCode(7634581) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000166.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c170000166.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		if e:GetLabel()>0 then
			Duel.RaiseSingleEvent(tc,170000166,e,REASON_EFFECT,tp,tp,e:GetLabel())
			e:SetLabel(0)
		end
	end
end
function c170000166.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil and tp==ep
end
function c170000166.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
	if ep==tp then
		e:GetLabelObject():SetLabel(ev)
	end
end
function c170000166.efilter(e,c)
	return c:GetOriginalCode()~=170000166
end
