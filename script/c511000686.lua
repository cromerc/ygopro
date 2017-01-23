--ＲＵＭ－ダーク・フォース
function c511000686.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511000686.condition)
	e1:SetTarget(c511000686.target)
	e1:SetOperation(c511000686.activate)
	c:RegisterEffect(e1)
end
function c511000686.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return eg:GetCount()==1 and tc:IsControler(tp) and bc:IsReason(REASON_BATTLE)
end
function c511000686.filter2(c,rk,e,tp)
	return c:GetRank()==rk 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000686.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=eg:GetFirst()
	local rk=tg:GetRank()
	if chkc then return chkc==tg end
	if chk==0 then
	return tg:IsOnField() and tg:IsCanBeEffectTarget(e) and tg:IsAbleToGrave() 
	and Duel.IsExistingMatchingCard(c511000686.filter2,tp,LOCATION_EXTRA,0,1,nil,rk+1,e,tp)
	and  Duel.IsExistingMatchingCard(c511000686.filter2,tp,LOCATION_EXTRA,0,1,nil,rk+2,e,tp) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,tg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511000686.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	if Duel.SendtoGrave(tc,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c511000686.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank()+1,e,tp):GetFirst()
	Duel.SpecialSummon(g1,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP_ATTACK)
	local g2=Duel.SelectMatchingCard(tp,c511000686.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank()+2,e,tp):GetFirst()
	Duel.SpecialSummon(g2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP_DEFENSE)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	g1:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	g1:RegisterEffect(e2,true)
	g1:CompleteProcedure()
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	g2:RegisterEffect(e3,true)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DISABLE_EFFECT)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	g2:RegisterEffect(e4,true)
	g2:CompleteProcedure()
end
