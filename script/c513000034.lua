--Transcendental Ruin
function c513000034.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c513000034.condition)
	e1:SetTarget(c513000034.target)
	e1:SetOperation(c513000034.activate)
	c:RegisterEffect(e1)
end
function c513000034.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc>0
end
function c513000034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 end
end
function c513000034.activate(e,tp,eg,ep,ev,re,r,rp)
	local op=re:GetOperation()
	Duel.ChangeChainOperation(ev,c513000034.repop(1-tp,op))
end
function c513000034.repop(p,op)
	return	function (e,tp,eg,ep,ev,re,r,rp)
				if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
					e:GetHandler():CancelToGrave(false)
				end
				if op then op(e,tp,eg,ep,ev,re,r,rp) end
				local sg=Duel.GetMatchingGroup(Card.IsDestructable,p,LOCATION_ONFIELD,0,nil)
				Duel.Destroy(sg,REASON_EFFECT)	
			end
end
