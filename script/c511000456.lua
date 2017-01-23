--Wish of Final Effort
function c511000456.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511000456.target)
	e1:SetOperation(c511000456.activate)
	c:RegisterEffect(e1)
end
function c511000456.filter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE) and c:GetAttack()>0
end
function c511000456.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc,tp) and c511000456.filter(chkc,tp) end
	if chk==0 then return eg:IsExists(c511000456.filter,1,nil,tp) end
	local g=eg:Filter(c511000456.filter,nil,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
end
function c511000456.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetLabelObject():GetAttack()
	Duel.Recover(tp,atk,REASON_EFFECT)
end
