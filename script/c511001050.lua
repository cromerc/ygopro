--幻影騎士団シャドーベイル
function c511001050.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001050.target)
	e1:SetOperation(c511001050.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001050,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c511001050.spcon)
	e2:SetTarget(c511001050.sptg)
	e2:SetOperation(c511001050.spop)
	c:RegisterEffect(e2)
end
function c511001050.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511001050.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
	end
end
function c511001050.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511001050.filter(c,e,tp)
	return c:IsCode(77462146) and Duel.IsPlayerCanSpecialSummonMonster(tp,77462146,0x10db,0x11,4,0,300,RACE_WARRIOR,ATTRIBUTE_DARK)
end
function c511001050.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001050.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)end
	local g=Duel.GetMatchingGroup(c511001050.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511001050.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c511001050.filter,tp,LOCATION_GRAVE,0,1,ft,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			tc:AddMonsterAttribute(TYPE_NORMAL)
			Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
			tc:AddMonsterAttributeComplete()
			local e7=Effect.CreateEffect(e:GetHandler())
			e7:SetType(EFFECT_TYPE_SINGLE)
			e7:SetCode(EFFECT_TO_GRAVE_REDIRECT)
			e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e7:SetReset(RESET_EVENT+0x47e0000)
			e7:SetValue(LOCATION_REMOVED)
			tc:RegisterEffect(e7,true)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
