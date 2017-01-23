--Dark Matter
function c513000090.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c513000090.condition)
	e1:SetTarget(c513000090.target)
	e1:SetOperation(c513000090.activate)
	c:RegisterEffect(e1)
end
function c513000090.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSetCard(0x301) and c:IsType(TYPE_MONSTER) 
		and c:IsControler(tp) and c:IsType(TYPE_SYNCHRO)
end
function c513000090.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000090.cfilter,1,nil,tp)
end
function c513000090.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c513000090.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.Draw(tp,2,REASON_EFFECT)
	if g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)==2 then
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
			tc:SetStatus(STATUS_SUMMON_TURN,true)
			tc=g:GetNext()
		end
		Duel.RaiseEvent(g,EVENT_MSET,e,REASON_EFFECT,tp,tp,0)
	end
end
