--The Phantom Knights of Double Badge
function c511009325.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511009325.condition)
	e1:SetTarget(c511009325.target)
	e1:SetOperation(c511009325.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18563744,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c511009325.atkcost)
	e2:SetTarget(c511009325.atktg)
	e2:SetOperation(c511009325.atkop)
	c:RegisterEffect(e2)
end
function c511009325.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511009325.filter(c,e)
	return c:IsFaceup() and c:IsSetCard(0x10db) and c:IsCanBeEffectTarget(e)
end
function c511009325.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg,2,2)
end
function c511009325.mfilter1(c,mg,exg)
	return mg:IsExists(c511009325.mfilter2,1,c,c,exg)
end
function c511009325.mfilter2(c,mc,exg)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,Group.FromCards(c,mc))
end
function c511009325.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c511009325.filter,tp,LOCATION_MZONE,0,nil,e)
	local exg=Duel.GetMatchingGroup(c511009325.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and exg:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg1=mg:FilterSelect(tp,c511009325.mfilter1,1,1,nil,mg,exg)
	local tc1=sg1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg2=mg:FilterSelect(tp,c511009325.mfilter2,1,1,tc1,tc1,exg)
	sg1:Merge(sg2)
	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511009325.tfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsFaceup()
end
function c511009325.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511009325.tfilter,nil,e)
	if g:GetCount()<2 then return end
	local xyzg=Duel.GetMatchingGroup(c511009325.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end
function c511009325.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511009325.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c511009325.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009325.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009325.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009325.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009325.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local ct=tc:GetOverlayCount()
		tc:RemoveOverlayCard(tp,ct,ct,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(ct*500)
		tc:RegisterEffect(e1)
	end
end

