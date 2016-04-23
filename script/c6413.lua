--Scripted by Eerie Code
--Dice Roll Battle
function c6413.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6413,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c6413.spcon)
	e1:SetTarget(c6413.sptg)
	e1:SetOperation(c6413.spop)
	c:RegisterEffect(e1)
	--Battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6413,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(TIMING_BATTLE_PHASE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c6413.condition)
	e2:SetCost(c6413.cost)
	e2:SetTarget(c6413.target)
	e2:SetOperation(c6413.operation)
	c:RegisterEffect(e2)
end

function c6413.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c6413.spfil1(c,e,tp)
	return c:IsSetCard(0x2016) and c:IsAbleToRemove() and Duel.IsExistingMatchingCard(c6413.spfil2,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetOriginalLevel())
end
function c6413.spfil2(c,e,tp,lv)
	return c:IsSetCard(0x2016) and c:IsType(TYPE_TUNER) and c:IsAbleToRemove() and Duel.IsExistingMatchingCard(c6413.spfil3,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetOriginalLevel()+lv)
end
function c6413.spfil3(c,e,tp,lv)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6413.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6413.spfil1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and
		Duel.IsExistingTarget(c6413.spfil1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c6413.spfil1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6413.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local lv1=tc:GetOriginalLevel()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c6413.spfil2,tp,LOCATION_HAND,0,1,1,nil,e,tp,lv1)
		if g:GetCount()>0 then
			local tc2=g:GetFirst()
			local lv2=tc2:GetOriginalLevel()
			local rg=Group.FromCards(tc,tc2)
			if Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)>0 then
				local g2=Duel.SelectMatchingCard(tp,c6413.spfil3,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv1+lv2)
				if g2:GetCount()>0 then
					Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)
				end
			end
		end
	end
end

function c6413.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.GetCurrentChain()==0
end
function c6413.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6413.filter(c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK) and c:IsType(TYPE_SYNCHRO)
end
function c6413.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c6413.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(c6413.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g1=Duel.SelectTarget(tp,c6413.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	local g2=Duel.SelectTarget(tp,c6413.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c6413.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and tc2:IsRelateToEffect(e) then
		Duel.CalculateDamage(tc2,tc1)
	end
end