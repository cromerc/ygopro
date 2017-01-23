--Sphin-Quiz
function c51102026.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c51102026.sumcon)
	e1:SetTarget(c51102026.sumtg)
	e1:SetOperation(c51102026.sumop)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c51102026.con)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Quest
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95100088,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c51102026.qcon)
	e3:SetOperation(c51102026.qop)
	c:RegisterEffect(e3)
end
function c51102026.sumcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	return rc:IsSetCard(0x213)
end
function c51102026.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c51102026.sumop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c51102026.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x213)
end
function c51102026.con(e)
	return Duel.IsExistingMatchingCard(c51102026.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c51102026.qcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and bt:IsSetCard(0x213)
end
function c51102026.qop(e,tp,eg,ep,ev,re,r,rp)
	local ghd=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_DECK,LOCATION_HAND+LOCATION_DECK)
	local gex=Duel.GetFieldGroup(tp,LOCATION_EXTRA,LOCATION_EXTRA)
	if ghd:GetCount()==0 and gex:GetCount()==0 then return end
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51102026,3))
	if ghd:GetCount()>0 and gex:GetCount()>0 then
		op=Duel.SelectOption(tp,aux.Stringid(51102026,0),aux.Stringid(51102026,1),aux.Stringid(51102026,2))
	elseif ghd:GetCount()>0 then
		Duel.SelectOption(tp,aux.Stringid(51102026,0))
		op=0
	else
		op=Duel.SelectOption(tp,aux.Stringid(51102026,1),aux.Stringid(51102026,2))
		op=op+1
	end
	local lv=0
	local quest=0
	if op==0 then
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102026,0))
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51102026,0))
		quest=Duel.AnnounceNumber(1-tp,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
		lv=ghd:GetMaxGroup(Card.GetLevel):GetFirst():GetLevel()
		Duel.ConfirmCards(1-tp,ghd)
		Duel.ConfirmCards(tp,ghd)
		Duel.ShuffleDeck(tp)
		Duel.ShuffleDeck(1-tp)
		Duel.ShuffleHand(tp)
		Duel.ShuffleHand(1-tp)
	elseif op==1 then
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102026,1))
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51102026,1))
		quest=Duel.AnnounceNumber(1-tp,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
		lv=gex:GetMaxGroup(Card.GetLevel):GetFirst():GetLevel()
		Duel.ConfirmCards(1-tp,gex)
		Duel.ConfirmCards(tp,gex)
	else
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102026,2))
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51102026,2))
		quest=Duel.AnnounceNumber(1-tp,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
		lv=gex:GetMaxGroup(Card.GetRank):GetFirst():GetRank()
		Duel.ConfirmCards(1-tp,gex)
		Duel.ConfirmCards(tp,gex)
	end
	if quest==lv then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if g:GetCount()>0 then
			local tg=g:GetMaxGroup(Card.GetAttack)
			if tg:GetCount()>1 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				tg=tg:Select(tp,1,1,nil)
				Duel.HintSelection(tg)
			end
			if Duel.Destroy(tg,REASON_EFFECT)>0 then
				Duel.Damage(tg:GetFirst():GetPreviousControler(),tg:GetFirst():GetAttack(),REASON_EFFECT)
			end
		end
	else
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
