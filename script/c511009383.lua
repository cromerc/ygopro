--D/D Brownie
--Fixed By TheOnePharaoh
--fixed by MLD
function c511009383.initial_effect(c)
	--pendulum summon 
	aux.EnablePendulumAttribute(c) 
	--SelfSummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66762372,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c511009383.spcon)
	e1:SetTarget(c511009383.sptg)
	e1:SetOperation(c511009383.spop)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(c511009383.regcon)
	e2:SetOperation(c511009383.regop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17540705,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c511009383.sccon)
	e3:SetTarget(c511009383.sctg)
	e3:SetOperation(c511009383.scop)
	c:RegisterEffect(e3)
end
function c511009383.cfilter(c,tp)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsControler(tp)
end
function c511009383.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009383.cfilter,1,nil,tp)
end
function c511009383.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009383.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c511009383.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM) and e:GetHandler():GetSummonLocation()==LOCATION_EXTRA
end
function c511009383.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511009383,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009383.sccon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511009383)~=0
end
function c511009383.filter(c,e,tp)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009383.tfilter(c)
	return c:IsSetCard(0xaf) and c:IsReleasableByEffect()
end
function c511009383.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511009383.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and e:GetHandler():IsReleasableByEffect() 
		and Duel.IsExistingMatchingCard(c511009383.tfilter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingTarget(c511009383.filter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009383.filter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009383.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsReleasableByEffect() then return end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c511009383.tfilter,tp,LOCATION_MZONE,0,1,1,c)
	if g:GetCount()>0 then
		g:AddCard(c)
		if Duel.Release(g,REASON_EFFECT)>1 and tc and tc:IsRelateToEffect(e) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
