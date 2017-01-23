--Basara
function c511000015.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e0)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetCost(c511000015.descost)
	e1:SetTarget(c511000015.destg)
	e1:SetOperation(c511000015.desop)
	c:RegisterEffect(e1)
end
function c511000015.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER)
		and Duel.IsExistingTarget(c511000015.dfilter,tp,0,LOCATION_MZONE,1,nil,c:GetLevel())
end
function c511000015.dfilter(c,lv)
	return c:IsFaceup() and c:IsLevelAbove(lv+1) and c:IsDestructable()
end
function c511000015.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000015.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c511000015.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local lv=g:GetFirst():GetLevel()
	e:SetLabel(lv)
	Duel.Release(g,REASON_COST)
end
function c511000015.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511000015.dfilter(chkc,e:GetLabel()) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000015.dfilter,tp,0,LOCATION_MZONE,1,1,nil,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end


function c511000015.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsControler(1-tp) and tc:IsRelateToEffect(e) and tc:IsLevelAbove(e:GetLabel()+1) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end