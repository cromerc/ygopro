--Future Vision
function c511001475.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001475.condition)
	e1:SetTarget(c511001475.target)
	e1:SetOperation(c511001475.activate)
	c:RegisterEffect(e1)
end
function c511001475.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end
function c511001475.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function c511001475.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if sg:GetCount()<=0 then return end
	local g=Duel.GetMatchingGroup(Card.IsType,1-tp,LOCATION_DECK,0,nil,TYPE_MONSTER)
	local dcount=Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)
	if dcount==0 then return end
	if g:GetCount()==0 then
		Duel.ConfirmDecktop(1-tp,dcount)
		return
	end
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	while tc do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			spcard=tc
		end
		tc=g:GetNext()
	end
	Duel.ConfirmDecktop(1-tp,dcount-seq)
	if sg:IsExists(Card.IsRace,1,nil,spcard:GetRace()) then
		Duel.Recover(1-tp,1000,REASON_EFFECT)
	end
end
