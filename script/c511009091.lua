--D/D Savant Thomas (anime)
function c511009091.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--Back to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41546,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009091.thtg)
	e1:SetOperation(c511009091.thop)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41546,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,41546)
	e2:SetTarget(c511009091.sptg)
	e2:SetOperation(c511009091.spop)
	c:RegisterEffect(e2)
end

function c511009091.thfil(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c511009091.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009091.thfil,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c511009091.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511009091.thfil,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c511009091.spcfil(c)
	local seq=c:GetSequence()
	return c:IsSetCard(0xaf) and (seq==6 or seq==7) and c:IsDestructable()
end
function c511009091.spfil(c,e,tp)
	return c:IsSetCard(0x10af) and c:GetLevel()==8 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009091.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511009091.spcfil(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511009091.spcfil,tp,LOCATION_SZONE,0,1,nil) and Duel.IsExistingMatchingCard(c511009091.spfil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009091.spcfil,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009091.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511009091.spfil,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local sc=g:GetFirst()
		if sc and Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e2)
			
			Duel.RegisterEffect(e3,tp)
			Duel.SpecialSummonComplete()
		end
	end
end
