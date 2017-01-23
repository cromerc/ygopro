--Climax Hour
function c511000486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000486.target)
	e1:SetOperation(c511000486.activate)
	c:RegisterEffect(e1)
end
function c511000486.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c511000486.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DRAW)	
	e1:SetCountLimit(1)
	e1:SetLabel(0)
	e1:SetCondition(c511000486.spcon)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,4)
	e1:SetOperation(c511000486.spop)
	Duel.RegisterEffect(e1,tp)
end
function c511000486.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c511000486.spop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=e:GetOwnerPlayer() then return end
	local ct=e:GetLabel()+1
	e:SetLabel(ct)
	if e:GetLabel()==3 then
		local tc=eg:GetFirst()
		Duel.ConfirmCards(tp,tc)
		if tc:IsType(TYPE_MONSTER) and tc:IsCanBeSpecialSummoned(e,0,tp,true,false) then
			if Duel.SelectYesNo(tp,aux.Stringid(511000486,0)) then
				Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
			end
		end
		Duel.ShuffleHand(tp)
	end
end
