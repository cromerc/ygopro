--Battleguard Mad Shaman
function c511001295.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17132130,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetValue(1)
	e1:SetCondition(c511001295.spcon)
	e1:SetOperation(c511001295.spop)
	c:RegisterEffect(e1)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c511001295.ctcon)
	e3:SetTarget(c511001295.cttg)
	e3:SetOperation(c511001295.ctop)
	c:RegisterEffect(e3)
	--cannot be battle target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetCondition(c511001295.con)
	e4:SetValue(aux.imval1)
	c:RegisterEffect(e4)
	--switch
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511001295,0))
	e5:SetCategory(CATEGORY_CONTROL)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetTarget(c511001295.swtg)
	e5:SetOperation(c511001295.swop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)
	--control
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_CONTROL_CHANGED)
	e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetOperation(c511001295.conop)
	c:RegisterEffect(e8)
end
function c511001295.trfilter(c)
	return (c:IsSetCard(0x2310) or c:IsCode(39389320) or c:IsCode(40453765) or c:IsCode(20394040))
end
function c511001295.spcon(e,c)
	if c==nil then return true end
	local g=Duel.GetReleaseGroup(c:GetControler())
	local d=g:FilterCount(c511001295.trfilter,nil)
	local ct=g:GetCount()
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and d>0 and ct>2
end
function c511001295.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(c:GetControler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg1=g:FilterSelect(tp,c511001295.trfilter,1,1,nil)
	g:RemoveCard(sg1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg2=g:Select(tp,2,2,nil)
	sg2:Merge(sg1)
	Duel.Release(sg2,REASON_COST)
end
function c511001295.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	return not g:IsExists(Card.IsControler,1,nil,tp)
end
function c511001295.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511001295.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.GetControl(tc,tp) then
			if c:GetFlagEffect(511001295)==0 then
				c:RegisterFlagEffect(511001295,RESET_EVENT+0x1fe0000,0,0)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_SET_CONTROL)
				e1:SetRange(LOCATION_MZONE)
				e1:SetTargetRange(LOCATION_MZONE,0)
				e1:SetTarget(c511001295.cttg2)
				e1:SetValue(c511001295.ctval)
				c:RegisterEffect(e1)
			end
			c:SetCardTarget(tc)
		end
	end
end
function c511001295.ctval(e,c)
	return e:GetHandlerPlayer()
end
function c511001295.cttg2(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511001295.filter(c,e)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511001295.con(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c511001295.filter,c:GetControler(),LOCATION_MZONE,0,1,c,e)
end
function c511001295.swfilter(c,tp,atk)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:GetSummonPlayer()==1-tp
		and c:GetAttack()>atk
end
function c511001295.swtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetCardTarget():Filter(Card.IsControler,nil,tp):GetFirst()
	if not g then return false end
	local atk=g:GetAttack()
	if chk==0 then return eg:IsExists(c511001295.swfilter,1,nil,tp,atk) end
	local g2=eg:Filter(c511001295.swfilter,nil,tp,atk)
	if g2:GetCount()>0 then
		if g2:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			g2=g2:Select(tp,1,1,nil)
		end
	end
	g2:AddCard(g)
	Duel.SetTargetCard(g2)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g2,2,0,0)
end
function c511001295.swop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	g=g:Filter(Card.IsRelateToEffect,nil,e)
	local g1=g:GetFirst()
	local g2=g:GetNext()
	if g1:IsControler(1-tp) then g1,g2=g2,g1 end
	if g:GetCount()>1 then
		Duel.SwapControl(g1,g2,0,0)
		e:GetHandler():SetCardTarget(g2)
	end
end
function c511001295.conop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget():Filter(Card.IsControler,nil,tp)
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local des=g:Select(tp,1,1,nil)
		Duel.Destroy(des,REASON_EFFECT)
	end
end
