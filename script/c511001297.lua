--Battleguard's Curse
function c511001297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,51101297+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c511001297.condition)
	e1:SetTarget(c511001297.target)
	e1:SetOperation(c511001297.activate)
	c:RegisterEffect(e1)
end
function c511001297.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x2310) or c:IsCode(39389320) or c:IsCode(40453765) or c:IsCode(20394040))
end
function c511001297.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001297.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c511001297.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511001297.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
