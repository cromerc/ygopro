--The Twin Kings, Founders of the Empire
function c501000079.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--match winner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c501000079.cost)
	e2:SetTarget(c501000079.tg)
	e2:SetOperation(c501000079.op)
	c:RegisterEffect(e2)
	--spsummon condition
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c501000079.splimit)
	c:RegisterEffect(e3)
	--summon with 3 tribute
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e4:SetCondition(c501000079.ttcon)
	e4:SetOperation(c501000079.ttop)
	e4:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e4)
	--tribute limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_TRIBUTE_LIMIT)
	e5:SetValue(c501000079.tlimit)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_LIMIT_SET_PROC)
	e6:SetCondition(c501000079.setcon)
	c:RegisterEffect(e6)
	--match kill
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_MATCH_KILL)
	e7:SetCondition(c501000079.con)
	c:RegisterEffect(e7)
end
c501000079.illegal=true
function c501000079.cfilter(c)
	return c:IsRace(RACE_BEAST) and c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost()
end
function c501000079.filter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and (not e or c:IsCanBeEffectTarget(e)) 
		and (not tp or Duel.IsExistingMatchingCard(c501000079.cfilter,tp,LOCATION_MZONE,0,3,c))
end
function c501000079.nbfilter(c)
	return not c:IsRace(RACE_BEAST)
end
function c501000079.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local pentg=Duel.GetMatchingGroup(c501000079.filter,tp,LOCATION_MZONE,0,nil,e,tp)
	local pct=pentg:GetCount()
	if chk==0 then return pct>0 end
	local sg=Duel.GetMatchingGroup(c501000079.cfilter,tp,LOCATION_MZONE,0,nil)
	local g
	if pct==1 then
		sg:Sub(pentg)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=sg:Select(tp,3,3,nil)
	elseif pentg:FilterCount(c501000079.nbfilter,nil)>0 or pct>=4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=sg:Select(tp,3,3,nil)
	elseif pct==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=sg:FilterSelect(tp,Card.IsFacedown,2,2,nil)
		sg:Sub(g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g2=sg:Select(tp,1,1,nil)
		g:Merge(g2)
	elseif pct==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=sg:FilterSelect(tp,Card.IsFacedown,1,1,nil)
		sg:Sub(g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g2=sg:Select(tp,2,2,nil)
		g:Merge(g2)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c501000079.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c501000079.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c501000079.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c501000079.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c501000079.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MATCH_KILL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c501000079.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c501000079.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c501000079.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c501000079.tlimit(e,c)
	return not c:IsRace(RACE_BEAST)
end
function c501000079.setcon(e,c)
	if not c then return true end
	return false
end
function c501000079.con(e)
	local tp=e:GetHandler():GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
