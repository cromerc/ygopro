--炎獣の影霊衣－セフィラエグザ
function c5504.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c5504.splimit)
	e2:SetCondition(c5504.splimcon)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e3:SetCode(EVENT_DESTROY)
	e3:SetCountLimit(1,5504)
	e3:SetCondition(c5504.condition)
	e3:SetTarget(c5504.target)
	e3:SetOperation(c5504.operation)
	c:RegisterEffect(e3)
end
function c5504.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb4) or c:IsSetCard(0xc3) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c5504.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c5504.filter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsControler(tp) and not c:IsCode(5504) and (c:IsSetCard(0xb4) or c:IsSetCard(0xc3))
		and (c:IsLocation(LOCATION_MZONE) or (c:IsLocation(LOCATION_SZONE) and (c:GetSequence()==6 or c:GetSequence()==7)))
end
function c5504.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5504.filter,1,nil,tp)
end
function c5504.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c5504.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end
