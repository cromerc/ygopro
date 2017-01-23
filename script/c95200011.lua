--Commande duel 11
function c95200011.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200011.target)
	e1:SetOperation(c95200011.operation)
	c:RegisterEffect(e1)
end
function c95200011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,2000)
end
function c95200011.operation(e,tp,eg,ep,ev,re,r,rp)
	
	while winnerTp<1 or winnerOp<1 do
	-- your Rock (1) Paper (2) Scissor (3)
	local choiceTp=Duel.SelectOption(tp,aux.Stringid(95200011,0),aux.Stringid(95200011,1),aux.Stringid(95200011,2))
	
	-- opponent Rock (1) Paper (2) Scissor (3)
	local choiceOp=Duel.SelectOption(1-tp,aux.Stringid(95200011,0),aux.Stringid(95200011,1),aux.Stringid(95200011,2))
	
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
		Duel.Recover(tp,2000,REASON_EFFECT)
	else
		Duel.Recover(1-tp,2000,REASON_EFFECT)
	end
end