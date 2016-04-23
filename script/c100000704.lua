--ダークネス・アウトサイダー
function c100000704.initial_effect(c)
	--dishand
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
    e2:SetCost(c100000704.spcost)
	e2:SetTarget(c100000704.target)
	e2:SetOperation(c100000704.operation)
	c:RegisterEffect(e2)
end
function c100000704.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
   Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c100000704.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local ac=Duel.AnnounceCard(tp)
	e:SetLabel(ac)
	e:GetHandler():SetHint(CHINT_CARD,ac)
end
function c100000704.filter(c,ac,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCode(ac) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000704.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=e:GetLabel()
	local g=Duel.GetFirstMatchingCard(c100000704.filter,tp,0,LOCATION_DECK,nil,ac,e,tp)
	if g then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.SendtoDeck(e:GetHandler(),1-tp,1,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
	end
end

