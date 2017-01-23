--Unfinished Time Box
function c511001269.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001269.condition)
	e1:SetTarget(c511001269.target)
	e1:SetOperation(c511001269.operation)
	c:RegisterEffect(e1)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511001269.spop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511001269.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp
end
function c511001269.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return eg:GetCount()==1 and ec:IsReason(REASON_BATTLE) and ec:GetPreviousControler()==tp
end
function c511001269.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst():GetReasonCard()
	if chk==0 then return tc:IsOnField() and tc:IsAbleToRemove() and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001269.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT) then
		e:SetLabelObject(tc)
		tc:RegisterFlagEffect(511001269,RESET_EVENT+0x1fe0000,0,1)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c511001269.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject():GetLabelObject()
	if tc and tc:GetFlagEffect(511001269)>0 and tc:IsCanBeSpecialSummoned(e,0,1-tp,false,false) then
		Duel.SpecialSummon(tc,0,1-tp,1-tp,false,false,POS_FACEUP)
	end
	e:GetLabelObject():SetLabelObject(nil)
end
