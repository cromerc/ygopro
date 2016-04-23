--悪魔竜ブラック・デーモンズ・ドラゴン
function c5639.initial_effect(c)
	c:SetSPSummonOnce(5639)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c5639.mfilter1,c5639.mfilter2,true)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5639,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c5639.condition)
	e1:SetTarget(c5639.damtg)
	e1:SetOperation(c5639.damop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c5639.aclimit)
	e2:SetCondition(c5639.actcon)
	c:RegisterEffect(e2)
end
function c5639.mfilter1(c)
	return c:IsSetCard(0x45) and c:IsType(TYPE_NORMAL) and c:GetLevel()==6
end
function c5639.mfilter2(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_NORMAL)
end
function c5639.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c5639.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c5639.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
		and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c5639.filter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_NORMAL) and c:IsAbleToDeck()
end
function c5639.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c5639.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c5639.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,c5639.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c5639.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
