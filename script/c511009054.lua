--Rank-Up-Magic The Phantom Knights of Launch
function c511009054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009054.target)
	e1:SetOperation(c511009054.activate)
	c:RegisterEffect(e1)
	
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetDescription(aux.Stringid(511000818,0))
	e2:SetCondition(c511009054.tdcon)
	e2:SetOperation(c511009054.tdop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511009054.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c511009054.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1,c:GetCode())
end
function c511009054.filter2(c,e,tp,mc,rk,code)
	if c.rum_limit_code and code~=c.rum_limit_code then return false end
	return c:GetRank()==rk and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511009054.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009054.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c511009054.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009054.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511009054.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009054.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		if (tc:IsSetCard(0x10db) or tc:IsCode(16195942)) and Duel.SelectYesNo(tp,aux.Stringid(95100814,0)) then
		e:GetHandler():CancelToGrave()
		Duel.Overlay(sc,Group.FromCards(e:GetHandler()))
		end
		
		sc:CompleteProcedure()
		e:GetLabelObject():SetLabelObject(sc)
	end
end

---------------------------

function c511009054.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetLabelObject() and e:GetLabelObject():IsLocation(LOCATION_MZONE)
end

function c511009054.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return e:GetHandler():IsAbleToHand() and tc:IsLocation(LOCATION_MZONE) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c511009054.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	
	if tc:IsLocation(LOCATION_MZONE) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
