--Ｖ・ＨＥＲＯ グラビート
function c100000508.initial_effect(c)		
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c100000508.cost)
	e1:SetTarget(c100000508.sptg)
	e1:SetOperation(c100000508.spop)
	c:RegisterEffect(e1)
end
function c100000508.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c100000508.filter(c,e,sp)
	return c:IsFaceup() and c:IsSetCard(0x5008) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c100000508.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c100000508.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c100000508.filter,tp,LOCATION_SZONE,0,2,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000508.filter,tp,LOCATION_SZONE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000508.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)	
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<sg:GetCount() then return end
	Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
end
