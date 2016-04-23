--Scripted by Eerie Code
--Youtou - Shiranui
function c6831.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6831,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c6831.condition)
	e1:SetTarget(c6831.target)
	e1:SetOperation(c6831.operation)
	c:RegisterEffect(e1)
end

function c6831.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c6831.filter1(c,e,tp)
	return c:IsRace(RACE_ZOMBIE) and not c:IsType(TYPE_TUNER) and c:GetLevel()>0 and Duel.IsExistingMatchingCard(c6831.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel()+e:GetHandler():GetLevel())
end
function c6831.filter2(c,e,tp,lv)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_ZOMBIE) and c:GetLevel()==lv and c:IsAbleToRemoveAsCost() and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,false,false)
end
function c6831.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6831.filter1(chkc,e,tp) end
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.IsPlayerCanSpecialSummonCount(tp,1) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c6831.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	Duel.SelectTarget(tp,c6831.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c6831.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local lv=c:GetLevel()+tc:GetLevel()
		local tg=Group.FromCards(c,tc)
		if Duel.Remove(tg,POS_FACEUP,REASON_COST)>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c6831.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv)
			Duel.SpecialSummon(g,SUMMON_TYPE_SPECIAL,tp,tp,false,false,POS_FACEUP)
		end
	end
end