--Ｓｐ－エネミーコントローラー
function c100100520.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c100100520.con)
	e1:SetCost(c100100520.cost)
	e1:SetTarget(c100100520.target)
	e1:SetOperation(c100100520.activate)
	c:RegisterEffect(e1)
end
function c100100520.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>2
end
function c100100520.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c100100520.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function c100100520.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then		
		e:SetLabel(0)
		return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
	end
	local g=Duel.GetMatchingGroup(c100100520.filter,tp,0,LOCATION_MZONE,nil,e)
	local cg=nil
	if e:GetLabel()==1 then cg=g:Filter(Card.IsAbleToChangeControler,nil)
	else cg=g:Filter(Card.IsControlerCanBeChanged,nil) end
	local sel=0
	Duel.Hint(HINT_SELECTMSG,tp,550)
	if cg:GetCount()==0 then
		sel=Duel.SelectOption(tp,aux.Stringid(100100520,0))
	elseif e:GetLabel()==1 and not Duel.CheckReleaseGroup(tp,nil,1,nil) then
		sel=Duel.SelectOption(tp,aux.Stringid(100100520,0))
	else
		sel=Duel.SelectOption(tp,aux.Stringid(100100520,0),aux.Stringid(100100520,1))
		if sel==1 and e:GetLabel()==1 then
			local rg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
			Duel.Release(rg,REASON_COST)
		end
	end
	if sel==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local sg=cg:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	end
	e:SetLabel(sel)
end
function c100100520.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if e:GetLabel()==0 then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
		else
			Duel.GetControl(tc,tp,PHASE_END,1)
		end
	end
end
