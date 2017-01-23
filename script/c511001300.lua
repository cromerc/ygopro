--Respect Synchron
function c511001300.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DELAYED_QUICKEFFECT)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511001300.spcon)
	e1:SetTarget(c511001300.sptg)
	e1:SetOperation(c511001300.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001300.descon)
	e2:SetOperation(c511001300.desop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511001300.desop2)
	c:RegisterEffect(e3)
end
function c511001300.cfilter(c,e,tp,r,rp)
	return c:IsType(TYPE_SYNCHRO) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==1-tp and bit.band(r,REASON_EFFECT)~=0 
		and rp~=tp and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511001300.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001300.cfilter,nil,e,tp,r,rp)
	return g:GetCount()==1 
end
function c511001300.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511001300.cfilter,nil,e,tp,r,rp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g:GetFirst(),1,tp,LOCATION_GRAVE)
end
function c511001300.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		c:SetCardTarget(tc)		
	end
end
function c511001300.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001300.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511001300.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
