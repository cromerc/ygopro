--Commande duel 12
function c95200012.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200012.target)
	e1:SetOperation(c95200012.operation)
	c:RegisterEffect(e1)
end
function c95200012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,2000)
end
function c95200012.operation(e,tp,eg,ep,ev,re,r,rp)
	while winnerTp<1 or winnerOp<1 do
	-- your Rock (1) Paper (2) Scissor (3)
	local choiceTp=Duel.SelectOption(tp,aux.Stringid(95200012,0),aux.Stringid(95200012,1),aux.Stringid(95200012,2))
	
	-- opponent Rock (1) Paper (2) Scissor (3)
	local choiceOp=Duel.SelectOption(1-tp,aux.Stringid(95200012,0),aux.Stringid(95200012,1),aux.Stringid(95200012,2))
	
	if choiceTp==1 then
		-- you=Rock op=Paper
		if choiceOp==2 then
		winnerOp=1
		end
		-- you=Rock op=Scissor
		if choiceOp==3 then
		winnerTp=1
		end
	end
	if choiceTp==2 then
		-- you=Paper op=Rock
		if choiceOp==1 then
		winnerTp=1
		end
		-- you=Paper op=Scissor
		if choiceOp==3 then
		winnerOp=1
		end
	end
		if choiceTp==3 then
		-- you=Scissor op=Rock
		if choiceOp==1 then
		winnerOp=1
		end
		-- you=Scissor op=Paper
		if choiceOp==2 then
		winnerTp=1
		end
	end
	if choiceTp==1 then
	if not Duel.IsExistingTarget(c45894482.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then return end
		local g=Duel.SelectTarget(tp,c45894482.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
	else
	if not Duel.IsExistingTarget(c45894482.filter,1-tp,LOCATION_GRAVE,0,1,nil,e,tp) then return end
		local g=Duel.SelectTarget(1-tp,c45894482.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,1-tp,1-tp,false,false,POS_FACEUP)
	end
	end
end